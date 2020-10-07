Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A13C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89F0206D9
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUGMhaO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89F0206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8XO-0005ZK-OJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ8Ss-0001Jx-HV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ8Sp-0004c8-I3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602073354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ip9F0gxruQpyAkSHvS3Bk/U9KoNmdgqMYHlx1D+ubM=;
 b=CUGMhaO5LT6gmdYtFsZqLbcrT8D6JgpqVR85JWRnKtpzE507GutFptOzrgMZN5kMNsnrRq
 3V2o2fpwttYVlh94fiErgyj+wiO0LzyKxq6oo9EBWxey69+W+bMxd3RXtoSNjOJHp+1PgO
 TRgszLI6QVZlJE67oUcVBcsG6xBNzeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-gYHv-HQRMPm6Wz7uvN2YQw-1; Wed, 07 Oct 2020 08:22:32 -0400
X-MC-Unique: gYHv-HQRMPm6Wz7uvN2YQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 967E88064C2
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 12:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 673BB8CD21;
 Wed,  7 Oct 2020 12:22:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D88EC11329C1; Wed,  7 Oct 2020 14:22:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 29/36] qapi/gen.py: Remove unused parameter
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-30-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 14:22:28 +0200
In-Reply-To: <20201005195158.2348217-30-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:51 -0400")
Message-ID: <871riacjjv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> module_basename doesn't use the 'what' argument, so remove it.

_module_dirname(), I suppose.

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/gen.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index d0391cd8718..3624162bb77 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -259,7 +259,7 @@ def _is_user_module(name: Optional[str]) -> bool:
>      def _is_builtin_module(name: Optional[str]) -> bool:
>          return not name
>  
> -    def _module_dirname(self, what: str, name: Optional[str]) -> str:
> +    def _module_dirname(self, name: Optional[str]) -> str:
>          if self._is_user_module(name):
>              return os.path.dirname(name)
>          return ''
> @@ -277,7 +277,7 @@ def _module_basename(self, what: str, name: Optional[str]) -> str:
>          return ret
>  
>      def _module_filename(self, what: str, name: Optional[str]) -> str:
> -        return os.path.join(self._module_dirname(what, name),
> +        return os.path.join(self._module_dirname(name),
>                              self._module_basename(what, name))
>  
>      def _add_module(self, name: Optional[str], blurb: str) -> None:


