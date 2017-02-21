Received: from eggs.gnu.org ([2001:4830:134:3::10]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg7F4-0004mk-Ej
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg7F3-0006HB-Ob
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:00:18 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg7F3-0006H6-IB
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:00:17 -0500
Received: by mail-wm0-x234.google.com with SMTP id v186so105090702wmd.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:00:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221022436.GA14453@pacoca>
References: <1478452528-13684-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1478452528-13684-8-git-send-email-joserz@linux.vnet.ibm.com>
	<CAFEAcA9HTc9QH51w5yhNoMjLk3jB4aM+Zp2MWBDN+xGnqf-cOw@mail.gmail.com>
	<20170221022436.GA14453@pacoca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 09:59:55 +0000
Message-ID: <CAFEAcA_M3R7g01x7SXNS584QLqCPSHc6A8YbRFAG1MYMFL3KDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu v2 7/9] Add PPC64 in risu build system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 February 2017 at 02:24,  <joserz@linux.vnet.ibm.com> wrote:
> On Sat, Feb 18, 2017 at 10:41:41PM +0000, Peter Maydell wrote:
>>
>> Does the BE ppc64 risu build work for you? I tried
>> installing the cross-compiler, but the build fails
>> because there's no risu_ppc64.c. (ppc64le works fine.)
>> If we don't support the big-endian variant yet maybe
>> we should drop it from the configure file.
>
> I want it to work to but I focused the efforts on LE only, never tested
> at all. I have a small patchset to send to you. I'll make an effort to fix BE as well,
> it's worth it.

Up to you -- if you're not using BE yet then we can just as
easily disable it in configure for the moment, until you
have a need to get back to it.

thanks
-- PMM
