Received: from eggs.gnu.org ([2001:4830:134:3::10]:55105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiJSD-0001b4-NP
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiJSA-0006nX-O8
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:03:45 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fiJSA-0006mw-JW
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:03:42 -0400
Received: by mail-io0-x241.google.com with SMTP id l7-v6so6252913ioj.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 06:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725125944.5nd5ydm4x4e3vvjw@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
	<20180725124700.GF12855@redhat.com>
	<20180725125944.5nd5ydm4x4e3vvjw@kamzik.brq.redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Jul 2018 15:03:40 +0200
Message-ID: <CAKv+Gu-pbJj59wH7wgZ6Uq+Uko9wYEBqSF=WaC3LL68CFkbxEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 25 July 2018 at 14:59, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Jul 25, 2018 at 01:47:00PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> Would iut make any sense to call the machine  "refplatform"  or "refboar=
d"
>> to indicate it is a generic reference platform, not specifically followi=
ng
>> any particular real impl, albeit influence by the sbsa spec.
>>
>
> That would indeed stop me from whining about a machine model with an
> 'sbsa' name not strictly implementing a minimal SBSA machine :-)
>

I still don't get why only a minimal machine is worth considering,
given that a real-world minimal SBSA machine is not capable of doing
anything useful.
