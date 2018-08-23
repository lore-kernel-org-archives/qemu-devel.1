Received: from eggs.gnu.org ([2001:4830:134:3::10]:56459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsqHF-0002f9-CO
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsqH9-0006tB-R4
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsqH9-0006sY-Hm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:51 -0400
Received: by mail-wr1-x42f.google.com with SMTP id v17-v6so4761984wrr.9
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:07:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180823113659.21737-1-pbonzini@redhat.com>
	<CAFEAcA9GTsKcteYCLC2jk0icxGYGX9R=Hbrph7CK3bugc3+kVQ@mail.gmail.com>
	<CAJ+F1CK=M3bX+8mo=AwkBj7Rd2ViqV1Y4q6WfQfS4_OFNDrdKA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df95fdae-c5c6-3651-a59a-89c624bfbbd6@redhat.com>
Date: Thu, 23 Aug 2018 16:07:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK=M3bX+8mo=AwkBj7Rd2ViqV1Y4q6WfQfS4_OFNDrdKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/73] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>

On 23/08/2018 15:37, Marc-André Lureau wrote:
> Hmm, it looks like a race that pre-existed char_socket_test_common(),
> we wait for the server to be connected, and check both client and
> server have the connected option set. It may be that the client hasn't
> yet processed the connection event.
> 
> Paolo, can you drop the test?
> 

Well, I dropped all the four patches. :)

Paolo
