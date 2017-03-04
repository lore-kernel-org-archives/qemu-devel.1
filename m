Received: from eggs.gnu.org ([2001:4830:134:3::10]:57660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck96j-00028B-UV
	for Qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck96i-00081c-US
	for Qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:48:21 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ck96i-00080d-OP
	for Qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:48:20 -0500
Received: by mail-wm0-x229.google.com with SMTP id n11so33418718wma.0
	for <Qemu-devel@nongnu.org>; Sat, 04 Mar 2017 04:48:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
References: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 12:47:59 +0000
Message-ID: <CAFEAcA9NPoujRE47pyNEui-DwxwisNpmGNp0w4B_+_mwbuV_4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hanley <jhanley@dgtlrift.com>
Cc: qemu-devel <Qemu-devel@nongnu.org>

On 3 March 2017 at 19:45, James Hanley <jhanley@dgtlrift.com> wrote:
> I'm trying to clone clean and I'm getting the following when initing the
> submodules updated:

> It's unclear to me what should be done for a pristine clone - is there a
> step missing from pulling those submodules?

I just did:
 git clone git://git.qemu-project.org/qemu.git
 cd qemu
 git submodule init
 git submodule update

and that worked for me.

(We do occasionally accidentally introduce an error where we
update the submodule but the qemu-project.org mirror of a
git repo hasn't yet moved forward to include the reference.
But it seems to all be OK at the moment.)

As an aside you typically don't need all the submodules if
you're just interested in building QEMU. (You might need
the dtc module but configure will tell you if you do and
also what command to ues to just get the dtc submodule
and not anything else.)

thanks
-- PMM
