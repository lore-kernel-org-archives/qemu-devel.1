Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB99C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E92F222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXWmnIOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92F222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQdg-0001MS-TH
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kXQWC-0007pr-G6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kXQW8-0005n5-8x
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kULO0K0PYfVWwTw4rsBlloW1pF6z7Uysc1OQ2YiAWvI=;
 b=fXWmnIOCDiCwss8u3XkW1sKyy09Zk2B2LGoI5spu9Z6XkrKZymXz/5UdrOX61iOHXPp/fb
 IDWe3uZLH6TChl2qLW+wO5LdaxGdQ1PlTQqyCaZt4q2fjdbjtUNmOV3W0OOf8zNxSUeNRr
 xpTkbE7ueCbYw8R4+n8yTCLDB8sGF7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-ptCuUlrqOYOz67EYefqh3w-1; Tue, 27 Oct 2020 11:02:52 -0400
X-MC-Unique: ptCuUlrqOYOz67EYefqh3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7836800597
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 15:02:51 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A75076EF45;
 Tue, 27 Oct 2020 15:02:51 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id E958F3E047D; Tue, 27 Oct 2020 16:02:49 +0100 (CET)
Date: Tue, 27 Oct 2020 16:02:49 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [qemu-web PATCH v2 11/16] Bring contribution links out of the
 footer into the home page
Message-ID: <20201027150249.GB64583@paraplu>
References: <20201027132015.621733-1-berrange@redhat.com>
 <20201027132015.621733-12-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027132015.621733-12-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kchamart@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 01:20:10PM +0000, Daniel P. Berrangé wrote:
> The selection of contribution links are important information to present
> to visitors to the site. They are best placed in a prominent position on
> the home page rather than in the footer
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Yeah, I personally didn't realize all the useful Contribute-related
links that were only one scroll away in the old page vs. having it front
and center in your new rendering:

    https://berrange.gitlab.io/qemu-web/

Definitely useful.

FWIW:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>    

> ---
>  _includes/footer.html | 7 -------
>  index.html            | 8 ++++++++
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/_includes/footer.html b/_includes/footer.html
> index 411ff55..07f7866 100644
> --- a/_includes/footer.html
> +++ b/_includes/footer.html
> @@ -5,13 +5,6 @@
>  			<li><a href="{{ relative_root }}/download">Download</a></li>
>  			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
>  		</ul>
> -		<ul class="style">
> -			<li><a href="{{ relative_root }}/contribute">Contribute</a></li>
> -			<li><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></li>
> -			<li><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
> -			<li><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
> -			<li><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
> -		</ul>
>  		<ul class="style">
>  			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
>  			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
> diff --git a/index.html b/index.html
> index d057a87..be1d210 100644
> --- a/index.html
> +++ b/index.html
> @@ -27,6 +27,14 @@ bxslider: True
>  			  <span><a href="{{ relative_root }}/download">Other releases</a></span>
>  			</li>
>  {% endfor %}
> +
> +			<li><strong>Contribute</strong>
> +			  <span><a href="{{ relative_root }}/contribute">Overview</a></span>
> +			  <span><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></span>
> +			  <span><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></span>
> +			  <span><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></span>
> +			  <span><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></span>
> +			</li>
>  		</ul>
>  	</div>
>  </div>
> -- 
> 2.26.2
> 
> 

-- 
/kashyap


