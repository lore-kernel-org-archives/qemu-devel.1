Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC688C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05CE20820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05CE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKzWO-00072j-T1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 02:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iKzVf-0006Rw-US
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iKzVd-000212-ET
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iKzVd-0001zm-5j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:43:41 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DAE57FDCA
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:43:39 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w10so462285wrl.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 23:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=YH4IfHpLSGIZeAPFoOryXas1VFS1OGJK8GTN2x4I58E=;
 b=ZGmPyEpu60WfoIeQZ+3M/nPdNU2DOQSlQjvQHoqoTSkuDSoWkwWp+B4vDtjd2gFhNp
 CefS4FOgw2lQ0lCkYqtQz9lsvDArs61T1cd226rPHI/QRdlwOXqZLRcOHITDErLtU2dd
 UhgraKR3Al2eWJopZDxiQRAs1sDsViX7lQ5kBSCgXnHp64NV0LXw2mjb6YOOEOarXHWm
 rkMvfnn0ySzRUtzRVi8rNyBwnYSwajBhc3m4/ioFuQUX9SgZHOQuzzAW6nYc0y4E/zfm
 65ieEC3iwPbzcVUYlC5cBM7hlexb0oFi+pqLobnEYj6JBtUF607ETbF5aP4AzO/VmiMw
 LFtQ==
X-Gm-Message-State: APjAAAUDdOES8aHgMdHjYAwZUyLi5eRr+UNTDQdxdeO8UtTSx8oHgDTz
 uwRYTLhXbER6KAwfU6gDlJALADBcJiFK8QnTxML5D/2sBTQ+cybnWRT597XaVtpNMdeGT0cUXyh
 G2Sp2prPUS6EFld8=
X-Received: by 2002:a5d:638c:: with SMTP id p12mr87703wru.136.1571294617019;
 Wed, 16 Oct 2019 23:43:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNqNDQ5vs6AGlfSU9Jct+nfH7ewWpmDIx0dFGuJcsc6+mkppsCII1hFEOR72mCeewEoSYHJQ==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr87684wru.136.1571294616712;
 Wed, 16 Oct 2019 23:43:36 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id m62sm1171642wmm.35.2019.10.16.23.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 23:43:35 -0700 (PDT)
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-5-slp@redhat.com>
 <b7baa2ab-210b-e7ef-399e-4dbbbc0ee0aa@redhat.com>
 <87wod4pgoy.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v9 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtol in x86_load_linux()
In-reply-to: <87wod4pgoy.fsf@dusky.pond.sub.org>
Date: Thu, 17 Oct 2019 08:43:30 +0200
Message-ID: <87k193hnxp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, ehabkost@redhat.com,
 mst@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Markus Armbruster <armbru@redhat.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
>> Hi Sergio,
>>
>> On 10/15/19 1:23 PM, Sergio Lopez wrote:
>>> Follow checkpatch.pl recommendation and replace the use of strtol with
>>> qemu_strtol in x86_load_linux().
>>
>> "with qemu_strtoui"
>>
>>>
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>> ---
>>>   hw/i386/pc.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 77e86bfc3d..c8608b8007 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -68,6 +68,7 @@
>>>   #include "qemu/config-file.h"
>>>   #include "qemu/error-report.h"
>>>   #include "qemu/option.h"
>>> +#include "qemu/cutils.h"
>>>   #include "hw/acpi/acpi.h"
>>>   #include "hw/acpi/cpu_hotplug.h"
>>>   #include "hw/boards.h"
>>> @@ -1202,6 +1203,7 @@ static void x86_load_linux(PCMachineState *pcms,
>>>       vmode =3D strstr(kernel_cmdline, "vga=3D");
>>>       if (vmode) {
>>>           unsigned int video_mode;
>>> +        int ret;
>>>           /* skip "vga=3D" */
>>>           vmode +=3D 4;
>>>           if (!strncmp(vmode, "normal", 6)) {
>>> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
>>>           } else if (!strncmp(vmode, "ask", 3)) {
>>>               video_mode =3D 0xfffd;
>>>           } else {
>>> -            video_mode =3D strtol(vmode, NULL, 0);
>>> +            ret =3D qemu_strtoui(vmode, NULL, 0, &video_mode);
>>> +            if (ret !=3D 0) {
>>> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s=
\n",
>>> +                        strerror(-ret));
>>
>> (Cc'ing Markus/Daniel just in case)
>>
>> I'm wondering if using fprintf() is appropriate, thinking about
>> instantiating a machine via libvirt, is this error reported to the
>> user?
>>
>> I first thought about using error_report() instead:
>>
>>     error_report("qemu: can't parse 'vga' parameter: %s",
>>                  strerror(-ret));
>
> Make that
>
>      error_report("can't parse 'vga' parameter: %s", strerror(-ret));
>
>> But this API is meaningful when used in console/monitor. We can't get
>> here from the monitor,
>
> True, but error_report() should be used anyway, because (1) it makes
> intent more obvious, and (2) it uses a uniform, featureful error format.
>
> With the proposed fprintf(), we get
>
>     qemu: can't parse 'vga' parameter: Numerical result out of range
>
> With error_report():
>
> * we report the *actual* argv[0] instead of "qemu"
>
> * we obey -msg timestamp=3Don
>
> * if "[PATCHv2 1/2] util/qemu-error: add guest name helper with -msg
>   options" gets accepted, we obey -msg guest-name=3Don, too
>
> * we have a common way to point to the offending command line argument
>   or configuration file line (not worth doing here)
>
> Please use error_report().
>
> [...]

But should we use error_report even if other occurrences in the same
function are using fprintf? Or are you suggesting to change those too?
If so, is it really worth it doing it now or can we do that in a future
patch (seems completely unrelated to this patch series)?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2oDZIACgkQ9GknjS8M
AjWOmhAAh5G21vFjYwf28Hj8kOkjZajaFmS8TXUVG//KNa2ALWFRea801M3117n5
HbVBTvEADjX0RF1btj6hswvYcx3HXvICHddeZYYw9wf6elcZ8uSp8OQPt70QQaIq
hWsok/Xo4XEURfnc6GAvWYaR8YJ2j8Ua04ubAYx10X3PiBzQrmqsGHlifk4wtCfk
AJILNX8zhNcZv+o6oKRfFeHfk0DlChgw3mh7QtMF0TV+o1iLQkHVm6EsYXvF16UU
eQvMHGXlHhIKyALc3J2t1yVO2LXFSWIP0Q2Z3d8Y0lWjF5etzHh2QAp1P1q51Kwm
bMLJ35oT4nLcdShzFQgWAUIHcVrrIfja4MhcPNKbzpXvvc4g5iewUnauC+lwUEzg
a671/RO+7nOiNmDYXRvpn59CoVup2b/+LrLdJeVGxMpIZDwdzXr1j6KQrFDdbx/n
jSiEW+2CDshaLeqoS80n0kH4JBOG1XpNKIg9OZkBsvkdU3hxcrmnhCu6FP1PJTgc
OrbW1hg6fCNHmJa5OFHfWZly6hmtLdL39z0UEW3MQii6SGdF70fLpw4BKfxnHZza
1mCSWqurSN6KX1scm79pcHRvoRm5Ztrlfh/LnQDsDwrwkJlHYueLcKGiGLcivEfQ
4Uu1R7zscti8ey+30zwETry6l9WaOBNM1cboxVFsy4J71cbuQlw=
=Fsht
-----END PGP SIGNATURE-----
--=-=-=--

