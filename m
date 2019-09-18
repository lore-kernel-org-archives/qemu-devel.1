Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAA9218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAA9218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXyv-0000FT-QH
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAXxl-0007ni-BY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAXxk-0001Lg-E4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAXxk-0001LH-9H
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:17:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B19C369DA
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:17:31 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j3so2236216wrn.7
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=coj2HuucAWogvZhTfaqk8cBzFZQYqXXvhONbluZyQ/E=;
 b=lJsz9b91fJPIJV+7TSjzVZVm0kBRz1/3c4pN9zPXWGNBJMmRx32AYYCoYQjLvBTO8F
 0Oj1ouEphKhUdQ2lDpnd3i1EtwuU+K6et9hfl3GNG0PiKukpvugMhLXtB1yyHhP4u5bG
 mANNv05iVlBMgYJFb31snabbHMeU2cz310ygsBAOEzoXK2JwCxcLdrnRjBtNjUArrUNa
 sLrOxkWqLadwSXCGUe9fRfaCcORzXZjzPSESJxliALE89wX5qNSUpdA9DnEbXPTIDQaK
 yvO5uH7VjxGkznAGjio4nbqpb61ZV/VwFFEDvJqJyAhzblFV5BRjokuYXFkQCjlJynJ4
 hcdA==
X-Gm-Message-State: APjAAAXeyEL9KVZT1JaNKXS+semJQ3ElkjolG7Ttl5TtYLef24XBD6Db
 xNOmphJM9IKq1PqDuylFpMuUqRyDEdns8Id/klWDsvTBYjG0loGWF7eP9Jr4Obre5OqcAqU0UE+
 MA3YmSlTfVMkN1Fw=
X-Received: by 2002:a1c:d185:: with SMTP id i127mr2420297wmg.28.1568805450107; 
 Wed, 18 Sep 2019 04:17:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzc98SREcvn5O3N3G+k0eVPhOAoJ0G82nTd20SvuunrqCT6CqoGbRaxbEe2wlLG+031N8uhDw==
X-Received: by 2002:a1c:d185:: with SMTP id i127mr2420287wmg.28.1568805449920; 
 Wed, 18 Sep 2019 04:17:29 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id t8sm4130853wrx.76.2019.09.18.04.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 04:17:29 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com,
 crosa@redhat.com
References: <20190918070654.19356-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f0feff14-f234-6975-aa89-6aa59daeb977@redhat.com>
Date: Wed, 18 Sep 2019 13:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918070654.19356-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RESEND PATCH] tests/acceptance: Specify arch for
 QueryCPUModelExpansion
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 9:06 AM, David Gibson wrote:
> At the moment this test runs on whatever the host arch is.  But it look=
s
> for 'unavailable-features' which is an x86 specific cpu property.  Tag =
it
> to always use qemu-system-x86_64.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/acceptance/cpu_queries.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> I sent this a while back, but it seems to have been forgotten.  As far
> as I can tell the current logic is Just Plain Wrong, on any host other
> than x86.
>=20
> diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_que=
ries.py
> index e71edec39f..af47d2795a 100644
> --- a/tests/acceptance/cpu_queries.py
> +++ b/tests/acceptance/cpu_queries.py
> @@ -18,6 +18,9 @@ class QueryCPUModelExpansion(Test):
>      """
> =20
>      def test(self):
> +        """
> +        :avocado: tags=3Darch:x86_64
> +        """
>          self.vm.set_machine('none')
>          self.vm.add_args('-S')
>          self.vm.launch()
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

