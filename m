Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC88FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEC82067D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEC82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkSU-0001tk-3X
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1iKkQO-0008Ni-8k
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1iKkQM-0001fF-MV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:37:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1iKkQM-0001Oj-Co
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:37:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9GEXTst071678; Wed, 16 Oct 2019 10:36:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vp3bsmv63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2019 10:36:01 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9GEZYtH079457;
 Wed, 16 Oct 2019 10:36:01 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vp3bsmv4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2019 10:36:01 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9GEZJ7L025568;
 Wed, 16 Oct 2019 14:35:59 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03dal.us.ibm.com with ESMTP id 2vk6f96g7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2019 14:35:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9GEZv3G58917252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2019 14:35:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78C4FC6057;
 Wed, 16 Oct 2019 14:35:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13370C6059;
 Wed, 16 Oct 2019 14:35:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2019 14:35:56 +0000 (GMT)
Subject: Re: [RFC v5 086/126] TPM: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-87-vsementsov@virtuozzo.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <0257a46f-afdd-bf8b-e5f4-c55daabb1102@linux.ibm.com>
Date: Wed, 16 Oct 2019 10:35:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-87-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-16_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 12:05 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatel, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
>
> This commit (together with its neighbors) was generated by
>
> for f in $(git grep -l errp \*.[ch]); do \
>      spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff $f; \
> done;
>
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>      ...
>      goto out;
>      ...
>      out:
> }
> patterns, with "out:" at function end.
>
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>
> (auto-msg was a file with this commit message)
>
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   hw/tpm/tpm_util.c | 7 +++----
>   tpm.c             | 7 +++----
>   2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 62b091f0c0..b0657bbbf2 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -47,8 +47,8 @@ static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>   static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>                       Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       DeviceState *dev = DEVICE(obj);
> -    Error *local_err = NULL;
>       Property *prop = opaque;
>       TPMBackend *s, **be = qdev_get_prop_ptr(dev, prop);
>       char *str;
> @@ -58,9 +58,8 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>           return;
>       }
>   
> -    visit_type_str(v, name, &str, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    visit_type_str(v, name, &str, errp);
> +    if (*errp) {
>           return;
>       }
>   
> diff --git a/tpm.c b/tpm.c
> index 9c9e20bbb7..359ebb7f68 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -81,11 +81,11 @@ TPMBackend *qemu_find_tpm_be(const char *id)
>   
>   static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       const char *value;
>       const char *id;
>       const TPMBackendClass *be;
>       TPMBackend *drv;
> -    Error *local_err = NULL;
>       int i;
>   
>       if (!QLIST_EMPTY(&tpm_backends)) {
> @@ -116,9 +116,8 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>       }
>   
>       /* validate backend specific opts */
> -    qemu_opts_validate(opts, be->opts, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    qemu_opts_validate(opts, be->opts, errp);
> +    if (*errp) {
>           return 1;
>       }
>   



