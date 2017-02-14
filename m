Received: from eggs.gnu.org ([2001:4830:134:3::10]:52284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdcji-0000bA-Aj
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdcjh-00041y-Fq
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:01:38 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdcjh-00041O-7a
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:01:37 -0500
Received: by mail-wr0-x231.google.com with SMTP id k90so169140517wrc.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:01:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871sv1dj47.fsf@dusky.pond.sub.org>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-9-git-send-email-armbru@redhat.com>
	<CAFEAcA_utp4m28Lk20vZ4u1UT7zPdkgywxJp2GS8WNFsNh_AOQ@mail.gmail.com>
	<871sv1dj47.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 13:01:15 +0000
Message-ID: <CAFEAcA82gvHyPXPO2eAddKHSMidFvdRNMDV-0ZGoYK6FHEzfTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 08/24] util/cutils: Clean up control flow
 around qemu_strtol() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 February 2017 at 12:58, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> Doesn't this change the semantics? Previously, for the
>> case of (eno == 0 && ep == nptr) we would both set
>> *endptr to ep and return -EINVAL. Now we only return -EINVAL
>> and leave *endptr alone.

> No change, as far as I can tell.

Ah, you're right, and I misread the diff. Sorry.

thanks
-- PMM
