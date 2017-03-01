Received: from eggs.gnu.org ([2001:4830:134:3::10]:33460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj8F9-0005WH-Db
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj8F8-00083f-K2
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:40:51 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj8F8-00082h-DY
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:40:50 -0500
Received: by mail-wm0-x22a.google.com with SMTP id n11so5332342wma.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 09:40:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVhb6FPh9HaC--7vqRgetuBQNvYt9BxeCp9KaNOTfLe8g@mail.gmail.com>
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
	<CAJSP0QVhb6FPh9HaC--7vqRgetuBQNvYt9BxeCp9KaNOTfLe8g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 17:40:26 +0000
Message-ID: <CAFEAcA-QvbAUs5bS6w8_BBFS7-2msfxPeDGE8HVS3z5LKMQKPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1 March 2017 at 13:27, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Feb 28, 2017 at 9:06 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Our seabios.git mirror @ qemu.org seems to not sync properly.  The
>> commit isn't there even though it was pushed a few days ago already
>> (only the tag was pushed today).  John, can you have a look please?
>> master branch, *-stable branches and all tags should be mirrored.
>
> Hi Gerd,
> It looks like the git mirrors weren't updating.  I kicked it and the
> necessary commit is now in the QEMU seabios.git mirror repo.
>
> It should be safe to merge this pull request now.

$ git submodule update
fatal: reference is not a tree: 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
Unable to checkout '5f4c7b13cdf9c450eb55645f4362ea58fa61b79b' in
submodule path 'roms/seabios'

Maybe this will update overnight?

thanks
-- PMM
