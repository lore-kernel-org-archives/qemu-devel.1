Received: from eggs.gnu.org ([2001:4830:134:3::10]:58856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f42VH-0004H7-JG
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f42VG-0004qV-Ol
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:52:27 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:40609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f42VG-0004qF-IW
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:52:26 -0400
Received: by mail-ot0-x233.google.com with SMTP id j8-v6so19147856ota.7
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 03:52:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522906473-11252-1-git-send-email-thuth@redhat.com>
References: <1522906473-11252-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 11:52:05 +0100
Message-ID: <CAFEAcA_n_QzDhbVCSknpNSR2zcM86oba8Ou+=NPC8y7AEH58Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/integratorcp: Don't do things
 that could be fatal in the instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 5 April 2018 at 06:34, Thomas Huth <thuth@redhat.com> wrote:
> An instance_init function must not fail - and might be called multiple ti=
mes,
> e.g. during device introspection with the 'device-list-properties' QMP
> command. Since the integratorcm device ignores this rule, QEMU currently
> aborts in this case (though it really should not):
>
> echo "{'execute':'qmp_capabilities'}"\
>      "{'execute':'device-list-properties',"\
>      "'arguments':{'typename':'integrator_core'}}" \
>      | arm-softmmu/qemu-system-arm -M integratorcp,accel=3Dqtest -qmp std=
io
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> RAMBlock "integrator.flash" already registered, abort!
> Aborted (core dumped)
>
> Move the problematic code to the realize() function instead to fix this
> problem.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
