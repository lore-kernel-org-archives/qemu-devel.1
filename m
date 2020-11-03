Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07015C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169EE22409
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qrYbDXtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169EE22409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZv2g-0006ek-TT
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kZv1E-0005pd-K5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:02:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kZv1C-00027t-FH
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:02:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A3C2JsQ014655
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2020 07:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=cNIgARiivTyOkEUSFFeM+bsbdjetqv21HquJ0TFfBx8=;
 b=qrYbDXtBHacxM532r7KSFpe6JWC6MHvAwtr6mOF+/rIY5iFWP7fbIUccZFXs/cz+KAHt
 K3/r255ObStxJ4jJ+vQrQAeelWbwnrIw/jW9hpur6qql5YCPeEfItxBjrCcDIQ0Db0nx
 oDoJY0RYLwfy4Po9iRmkTWy/MzW3b75UaEZ4A3mzy71xLq78chSG+zETjfwzKtj0yIKS
 mrQO9KrvuXFIKdHnuDtyzexKrDYiC3VuRzBjRcSgD5+h7VhCdo1MP5YkEDsxwXdKxHGx
 ccW8MEhALXqdn8PolRpMuPIPY5qNEiq7+SjfC+gDjQHRR/UOsnab3cD5Trj3YJqi5Vj8 fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34jyyt4c0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 07:02:27 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3C2RIo015393
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2020 07:02:27 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34jyyt4byq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 07:02:27 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3BsYUV014752;
 Tue, 3 Nov 2020 12:02:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 34j8rh8tsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 12:02:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A3C2Msu8913534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2020 12:02:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72E5DA4054;
 Tue,  3 Nov 2020 12:02:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2423DA4066;
 Tue,  3 Nov 2020 12:02:22 +0000 (GMT)
Received: from marcibm (unknown [9.145.145.228])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  3 Nov 2020 12:02:22 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: vhost-user-gpu/virtiofsd: use absolute path
In-Reply-To: <4798e23a-da0b-22f6-05bd-2373768a241c@redhat.com>
References: <20201103112333.24734-1-mhartmay@linux.ibm.com>
 <877dr28ysh.fsf@linux.ibm.com>
 <4798e23a-da0b-22f6-05bd-2373768a241c@redhat.com>
Date: Tue, 03 Nov 2020 13:02:21 +0100
Message-ID: <871rha8x82.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-03_08:2020-11-03,
 2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=2 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030079
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 05:07:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 12:55 PM +0100, Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> On 03/11/20 12:28, Marc Hartmayer wrote:
>> On Tue, Nov 03, 2020 at 12:23 PM +0100, Marc Hartmayer <mhartmay@linux.i=
bm.com> wrote:
>>> The option `libexecdir` is relative to `prefix` (see
>>> https://mesonbuild.com/Builtin-options.html), so we have to be aware
>>> of this when creating 50-qemu-gpu.json and
>>> 50-qemu-virtiofsd.json. Otherwise, tools like libvirt will not be able
>>> to find the executable.
>>>
>>> Fixes: 16bf7a3326d8 ("configure: move directory options from config-hos=
t.mak to meson")
>>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>> ---
>>>  contrib/vhost-user-gpu/meson.build | 2 +-
>>>  tools/virtiofsd/meson.build        | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gp=
u/meson.build
>>> index 37ecca13cafb..c487ca72c1ff 100644
>>> --- a/contrib/vhost-user-gpu/meson.build
>>> +++ b/contrib/vhost-user-gpu/meson.build
>>> @@ -9,6 +9,6 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in =
config_host \
>>>
>>>    configure_file(input: '50-qemu-gpu.json.in',
>>>                   output: '50-qemu-gpu.json',
>>> -                 configuration: { 'libexecdir' : get_option('libexecdi=
r') },
>>> +                 configuration: { 'libexecdir' : get_option('prefix') =
/ get_option('libexecdir') },
>>>                   install_dir: qemu_datadir / 'vhost-user')
>>>  endif
>>> diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
>>> index e1a4dc98d9ec..17edecf55c0a 100644
>>> --- a/tools/virtiofsd/meson.build
>>> +++ b/tools/virtiofsd/meson.build
>>> @@ -15,5 +15,5 @@ executable('virtiofsd', files(
>>>
>>>  configure_file(input: '50-qemu-virtiofsd.json.in',
>>>                 output: '50-qemu-virtiofsd.json',
>>> -               configuration: { 'libexecdir' : get_option('libexecdir'=
) },
>>> +               configuration: { 'libexecdir' : get_option('prefix') / =
get_option('libexecdir') },
>>>                 install_dir: qemu_datadir / 'vhost-user')
>>> --=20
>>> 2.25.4
>>>
>>>
>>=20
>> It=E2=80=99s probably not the best way to fix it, but at least a good hi=
nt
>> what=E2=80=99s wrong :)
>
> No, it's okay.  I queued it.

Thanks :)

>
> Paolo
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

