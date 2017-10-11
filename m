Received: from eggs.gnu.org ([2001:4830:134:3::10]:35894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2FqQ-0002q3-UN
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2FqQ-0004iy-0J
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:10:38 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2FqP-0004iZ-PK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:10:37 -0400
Received: by mail-wm0-x233.google.com with SMTP id f4so4215136wme.0
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 05:10:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <89139120-08aa-358c-f878-5c82a0d435b7@linux.vnet.ibm.com>
References: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAFEAcA-Kod+DTZ5MnG4JwswtKTj2PQw4Q8mhBN7sr50000M=Hg@mail.gmail.com>
	<89139120-08aa-358c-f878-5c82a0d435b7@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 13:10:16 +0100
Message-ID: <CAFEAcA8c4j4ebT=QJH5un3__2wGNhp86FXuuGKboYHRsDPa-wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/10] Merge tpm 2017/10/04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

On 11 October 2017 at 02:36, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> I installed OpenBSD 6.2 for i386 . I could recreate this one. PRIx64 solves
> it. I don't see the EBADMSG.  We include qemu/osdep.h in this file, so this
> is odd.

OpenBSD only added EBADMSG to its headers very recently:
https://github.com/openbsd/src/commit/bd616ed529e7c70988b09205b9cda0caa012efe8#diff-4c402341f93d93b29dc0f6eb539600f5
It's not in 6.1 or earlier.

thanks
-- PMM
