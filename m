Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7317CC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDF220716
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu8mwoE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDF220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9c3u-0008Kj-Cv
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9c2z-0007WO-TM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9c2y-0000fe-42
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:59:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9c2y-0000dz-0x
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583359159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0HPoCwBnbhUoyhNuPxdDTmsgW8Aia1xzIamnMqMOaE=;
 b=Zu8mwoE8diLBauBw6tKkBD7TrOcSaLv3W2HufMgYq1cN5ubS4kpxAm6KU4gpups/ShzGSp
 UAyssCD/x9Vqww6mG4eJuutqaiRbYvPt0J2DavnTplIpv8u2dCbRfezMqLrDmDnryfG34z
 Mx94VijeCx7h4EqBzu6i9NZh1u872Ws=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Z4U1p_WnO3eEOqHwrKX08w-1; Wed, 04 Mar 2020 16:59:17 -0500
X-MC-Unique: Z4U1p_WnO3eEOqHwrKX08w-1
Received: by mail-ed1-f72.google.com with SMTP id z20so2649578edr.11
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 13:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b0b4z1wyEpmy5s1j7xbaKdy0w1ccX/THHj5QUr4A0tM=;
 b=F9e5ZV1X6Xdlg3MgQrYKya+E2pLUXoPSW8I3nH3gSfEXGyeOV0U+slcWT71yO5Hvnp
 cp7SMdImUlUK1Pfzi6yiAwKFzRBosrWrUSCXtV2o02njPxcIZ3Ch3jtKc8IrWluGRnqi
 X9EjsxfSKVpN1UET/XxQzDxUAdBFnS2bygwi6o9NCDcdy35qLt0pzDtvLxAgBKY2Akkm
 zPsIHSU5ZH6gVB2yOuYZVBFHTgeBhQXTtnxvgnEGGgsbcwsMsw6QSPJIgigU89V6Tvx0
 sN6RA9T32nJn9q5e3Ti8oufYbT6s7HswNoqpfA376/Ym1bSt65X6v8r4zYcO9Fw1sASN
 Bmew==
X-Gm-Message-State: ANhLgQ36nrAYUtiC33UQoLs4DXP3+jkUzthiXcWatzrKi8xlg/Ykm/po
 v7PeQN+uWK8Ys5Q7+HRi4BnfjVRygWt7CMEUy3uUs+//vFTxyZChxSCuP5JhQQZD9hmuOvQKaRV
 BJe+dYDZ2Am804kw=
X-Received: by 2002:a50:e69c:: with SMTP id z28mr4956985edm.71.1583359156645; 
 Wed, 04 Mar 2020 13:59:16 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuwUfHzbVq2XtS5v+eEGkou6DPPeEOBjPFK3Knvh6XbVkKBaDRkwt8o2yyDAMUZBX+DtmL+bA==
X-Received: by 2002:a50:e69c:: with SMTP id z28mr4956960edm.71.1583359156219; 
 Wed, 04 Mar 2020 13:59:16 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id dx3sm535779ejb.0.2020.03.04.13.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 13:59:15 -0800 (PST)
Subject: Re: [PATCH v7 04/10] iotests: replace mutable list default args
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200304213818.15341-1-jsnow@redhat.com>
 <20200304213818.15341-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a210865b-6087-df5e-a15f-53f94e5c105a@redhat.com>
Date: Wed, 4 Mar 2020 22:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304213818.15341-5-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 10:38 PM, John Snow wrote:
> It's bad hygiene: if we modify this list, it will be modified across all
> invocations.
>=20
> (Remaining bad usages are fixed in a subsequent patch which changes the
> function signature anyway.)
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index fd65b90691..54d68774e1 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -136,7 +136,7 @@ def qemu_img_log(*args):
>       log(result, filters=3D[filter_testfiles])
>       return result
>  =20
> -def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_ar=
gs=3D[]):
> +def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_ar=
gs=3D()):
>       args =3D ['info']
>       if imgopts:
>           args.append('--image-opts')
> @@ -350,7 +350,7 @@ def _filter(_key, value):
>           return value
>       return filter_qmp(qmsg, _filter)
>  =20
> -def log(msg, filters=3D[], indent=3DNone):
> +def log(msg, filters=3D(), indent=3DNone):
>       '''Logs either a string message or a JSON serializable message (lik=
e QMP).
>       If indent is provided, JSON serializable messages are pretty-printe=
d.'''
>       for flt in filters:
> @@ -566,7 +566,7 @@ def get_qmp_events_filtered(self, wait=3D60.0):
>               result.append(filter_qmp_event(ev))
>           return result
>  =20
> -    def qmp_log(self, cmd, filters=3D[], indent=3DNone, **kwargs):
> +    def qmp_log(self, cmd, filters=3D(), indent=3DNone, **kwargs):
>           full_cmd =3D OrderedDict((
>               ("execute", cmd),
>               ("arguments", ordered_qmp(kwargs))
> @@ -967,7 +967,7 @@ def case_notrun(reason):
>       open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
>           '    [case not run] ' + reason + '\n')
>  =20
> -def verify_image_format(supported_fmts=3D[], unsupported_fmts=3D[]):
> +def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
>       assert not (supported_fmts and unsupported_fmts)
>  =20
>       if 'generic' in supported_fmts and \
> @@ -981,7 +981,7 @@ def verify_image_format(supported_fmts=3D[], unsuppor=
ted_fmts=3D[]):
>       if not_sup or (imgfmt in unsupported_fmts):
>           notrun('not suitable for this image format: %s' % imgfmt)
>  =20
> -def verify_protocol(supported=3D[], unsupported=3D[]):
> +def verify_protocol(supported=3D(), unsupported=3D()):
>       assert not (supported and unsupported)
>  =20
>       if 'generic' in supported:
> @@ -1000,11 +1000,11 @@ def verify_platform(supported=3DNone, unsupported=
=3DNone):
>           if not any((sys.platform.startswith(x) for x in supported)):
>               notrun('not suitable for this OS: %s' % sys.platform)
>  =20
> -def verify_cache_mode(supported_cache_modes=3D[]):
> +def verify_cache_mode(supported_cache_modes=3D()):
>       if supported_cache_modes and (cachemode not in supported_cache_mode=
s):
>           notrun('not suitable for this cache mode: %s' % cachemode)
>  =20
> -def verify_aio_mode(supported_aio_modes=3D[]):
> +def verify_aio_mode(supported_aio_modes=3D()):
>       if supported_aio_modes and (aiomode not in supported_aio_modes):
>           notrun('not suitable for this aio mode: %s' % aiomode)
>  =20
> @@ -1044,7 +1044,7 @@ def supported_formats(read_only=3DFalse):
>  =20
>       return supported_formats.formats[read_only]
>  =20
> -def skip_if_unsupported(required_formats=3D[], read_only=3DFalse):
> +def skip_if_unsupported(required_formats=3D(), read_only=3DFalse):
>       '''Skip Test Decorator
>          Runs the test if all the required formats are whitelisted'''
>       def skip_test_decorator(func):
> @@ -1095,11 +1095,11 @@ def execute_unittest(output, verbosity, debug):
>               sys.stderr.write(out)
>  =20
>   def execute_test(test_function=3DNone,
> -                 supported_fmts=3D[],
> +                 supported_fmts=3D(),
>                    supported_platforms=3DNone,
> -                 supported_cache_modes=3D[], supported_aio_modes=3D{},
> -                 unsupported_fmts=3D[], supported_protocols=3D[],
> -                 unsupported_protocols=3D[]):
> +                 supported_cache_modes=3D(), supported_aio_modes=3D(),
> +                 unsupported_fmts=3D(), supported_protocols=3D(),
> +                 unsupported_protocols=3D()):
>       """Run either unittest or script-style tests."""
>  =20
>       # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


