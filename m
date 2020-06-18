Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449B8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF40217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNGBgnpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF40217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlnPM-00024z-M5
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jlnOO-0001Rq-7G
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:47:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41917
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jlnOL-0007GF-Ee
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592459232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1FoU1l4Qo3AC9bNd9nsNf4OhBSrd+yH62hpW0g5jXv0=;
 b=UNGBgnpoLqcyJhoNChuLXO9RlTUPGXG5IGtNGiWZkzAXBgvoqJ5KUaHV4EgqxDmmm/+1/i
 Yljv+zR5+2wuai1dsy6QVqOI3k98pRDmdrPc80DCKBeCgZTmpJYbrhyFMqzy+yEaT/hGPj
 SYdOc9XKa5YASo/vVLDMiOPwnb/ZQfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-CJaL21qiP96p0hqS71OQiw-1; Thu, 18 Jun 2020 01:47:11 -0400
X-MC-Unique: CJaL21qiP96p0hqS71OQiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BBD418A0762;
 Thu, 18 Jun 2020 05:47:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2948C79319;
 Thu, 18 Jun 2020 05:47:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1F981132BD7; Thu, 18 Jun 2020 07:47:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/7] qemu-common: Briefly document qemu_timedate_diff()
 unit
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-2-f4bug@amsat.org>
Date: Thu, 18 Jun 2020 07:47:01 +0200
In-Reply-To: <20200616075121.12837-2-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 16 Jun 2020 09:51:15
 +0200")
Message-ID: <87d05xsz6y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <minyard@acm.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> It is not obvious that the qemu_timedate_diff() and
> qemu_ref_timedate() functions return seconds. Briefly
> document it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu-common.h | 1 +
>  softmmu/vl.c          | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index d0142f29ac..e97644710c 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -27,6 +27,7 @@ int qemu_main(int argc, char **argv, char **envp);
>  #endif
> =20
>  void qemu_get_timedate(struct tm *tm, int offset);
> +/* Returns difference with RTC reference time (in seconds) */
>  int qemu_timedate_diff(struct tm *tm);

Not this patch's problem: use of int here smells; is it wide enough?

> =20
>  void *qemu_oom_check(void *ptr);
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f669c06ede..215459c7b5 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -737,7 +737,7 @@ void qemu_system_vmstop_request(RunState state)
>  }
> =20
>  /***********************************************************/
> -/* RTC reference time/date access */
> +/* RTC reference time/date access (in seconds) */
>  static time_t qemu_ref_timedate(QEMUClockType clock)
>  {
>      time_t value =3D qemu_clock_get_ms(clock) / 1000;

time_t is seconds on all systems we support.  Using it for something
other than seconds would be wrong.  The comment feels redundant to me.
But if it helps someone else...


