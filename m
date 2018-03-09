Received: from eggs.gnu.org ([2001:4830:134:3::10]:52427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euIRd-0003Mx-Of
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euIRa-0000Q6-N4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:52:25 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:53055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1euIRa-0000Po-Gp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:52:22 -0500
Received: by mail-wm0-x235.google.com with SMTP id t3so4039134wmc.2
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:52:22 -0800 (PST)
References: <20180308130626.12393-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180308130626.12393-1-peter.maydell@linaro.org>
Date: Fri, 09 Mar 2018 13:52:19 +0000
Message-ID: <87zi3hjqzw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> This patchset adds support for '-cpu max' to Arm, along the lines
> of the existing support we have for x86 targets:
>
>  * under KVM, -cpu max is the same as -cpu host
>  * under TCG, -cpu max means "emulate with as many features as
>    possible"
<snip>

It all looks good to me. The only minor problem I ran into was setting
-M virt,gic-version=3Dmax silently hangs with the stock QEMU_EFI.fd on my
version of Ubuntu. It would be nice if there was better feedback we
could give to the user in this case.

It works with the latest snapshot from:

  http://snapshots.linaro.org/reference-platform/enterprise/firmware/15/rel=
ease/qemu-aarch64/

Anyway this series can have:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
