Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC26C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE0F22228
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zif7J8Vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE0F22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWKx-0007iN-Ly
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIWIl-0006gA-1z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIWIh-0003BM-5n
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600258357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjdqkQrNCOU8qKuPolN4l93DFE+SPQoKiV9fCSz9RZc=;
 b=Zif7J8Vr3yxZXc50tplzQKtX7fAe1+Pnd6NT+qWUZwQX3W+oWtUh+SCZRwc3RYfv0Ojxrq
 W0R/x6dfQVCUIuRTVp86ebIE3yVd5E+5bByTY+EiuyKXyEoux/miWoBvUBXTgXwdHkj/55
 DcVvJIMK9ahPCzCujK1adcYKQHbsCeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-IiN73Xa5Pcqu5f1kPbdRbA-1; Wed, 16 Sep 2020 08:12:36 -0400
X-MC-Unique: IiN73Xa5Pcqu5f1kPbdRbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1416A56B35;
 Wed, 16 Sep 2020 12:12:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 995855DA71;
 Wed, 16 Sep 2020 12:12:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 254C2113864A; Wed, 16 Sep 2020 14:12:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/37] qapi: delint using flake8
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-7-jsnow@redhat.com>
Date: Wed, 16 Sep 2020 14:12:31 +0200
In-Reply-To: <20200915224027.2529813-7-jsnow@redhat.com> (John Snow's message
 of "Tue, 15 Sep 2020 18:39:56 -0400")
Message-ID: <87wo0tor80.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Petty style guide fixes and line length enforcement.  Not a big win, not
> a big loss, but flake8 passes 100% on the qapi module, which gives us an
> easy baseline to enforce hereafter.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/.flake8     |  2 ++
>  scripts/qapi/commands.py |  3 ++-
>  scripts/qapi/schema.py   |  8 +++++---
>  scripts/qapi/visit.py    | 15 ++++++++++-----
>  4 files changed, 19 insertions(+), 9 deletions(-)
>  create mode 100644 scripts/qapi/.flake8
>
> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
> new file mode 100644
> index 0000000000..45d8146f3f
> --- /dev/null
> +++ b/scripts/qapi/.flake8
> @@ -0,0 +1,2 @@
> +[flake8]
> +extend-ignore = E722  # Pylint handles this, but smarter.

I guess you mean pylint's W0702 a.k.a. bare-except.  What's wrong with
flake8's E722 compared to pylint's W0702?

> \ No newline at end of file

So put one there :)

> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index e1df0e341f..2e4b4de0fa 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>  def gen_marshal_output(ret_type):
>      return mcgen('''
>  
> -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out, Error **errp)
> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
> +                                          Error **errp)

The continued parameter list may become misalignd in generated C.  E.g.

    static void qmp_marshal_output_BlockInfoList(BlockInfoList *ret_in, QObject **ret_out,
                                              Error **errp)
    {
    ...
    }

Do we care?

More of the same below.

>  {
>      Visitor *v;
>  
[...]


