Received: from eggs.gnu.org ([2001:4830:134:3::10]:53786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0INt-0003RK-V6
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0INs-0004jC-8t
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:33:37 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a]:40874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1g0INs-0004ix-0M
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:33:36 -0400
Received: by mail-ua1-x92a.google.com with SMTP id 101-v6so3573528uav.7
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 20:33:35 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Thu, 13 Sep 2018 11:33:34 +0800
Message-ID: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Can I only commit from active image to corresponding
 range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I split data to 3 chunks and save it in 3 independent backing files like
below:
img.000 <-- img.001 <-- img.002
img.000 is the backing file of img.001 and 001 is the backing file of 002.
img.000 saves the 1st chunk of data and img.001 saves the 2nd chunk of
data, and img.002 saves the 3rd chunk of data.

Now I have img.003 stores cow data of 1st chunk and img.002 is the backing
file of img.003.
The backing chain is like this:
  img.000 <-- img.001 <-- img.002 <-- img.003

So that means the data of img.003 saves the same range with img.000 but
different data.

I know I can use *`qemu-img commit'* but it only commit the data from
img.003 to img.002.

If I use *`qemu-img rebase -b img.000 img.003`*, the data of img.001 and
img.002 will merge into img.003.

What I want is only commit the data in img.003 into img.000 because the
data of the two image are the same range(1st chunk)

Is there anyway to commit(or merge) data of active image into corresponding
backing file?

thx
