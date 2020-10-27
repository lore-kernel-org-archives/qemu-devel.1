Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B3C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471B421556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn6w084Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471B421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRiY-0000r8-PI
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kXRhE-0008CK-5Z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kXRhB-0008Rx-3r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603815575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BSvvm1Y34Pam805oHvGmvxoyc9Xm3aSwSlsfKbVbic=;
 b=Bn6w084QN7q5K0caDIClKgkQIa//wj7K8vtUXmMCevgsRouRiiUCMg/3FSI8x3bwOqlyBh
 kShkMTGvt85PGlNoA9MaeNa/ToIHRH215rcdupxeVQIJZCPBlTeMA5sKe012BgtPb7FIJv
 TC9w9pg7dOP8SVIUl3bK/bmFljfXoJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152--x2coohzMd2ocH6XBqhfmg-1; Tue, 27 Oct 2020 12:19:27 -0400
X-MC-Unique: -x2coohzMd2ocH6XBqhfmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49CD9809DDA
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 16:19:26 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C02441972B;
 Tue, 27 Oct 2020 16:19:25 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 67DEF3E047D; Tue, 27 Oct 2020 17:19:24 +0100 (CET)
Date: Tue, 27 Oct 2020 17:19:24 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [qemu-web PATCH v2 06/16] Rework display of screenshots to use a
 carousel slider
Message-ID: <20201027161924.GC64583@paraplu>
References: <20201027132015.621733-1-berrange@redhat.com>
 <20201027132015.621733-7-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027132015.621733-7-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kchamart@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 01:20:05PM +0000, Daniel P. Berrangé wrote:
> We have a number of screenshots to display, with three fitted across the
> width of the screen. The screenshots dominate the usage of screen real
> estate on the front page, with other relevant information off the bottom
> of the page.
> 
> As a step towards increasing the information density of the home screen
> replace the horizontally presented screenshots with a rotating carousel
> of images.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  _data/screenshots.yml     | 14 ++++++++++++--
>  _includes/screenshot.html |  8 ++++++--
>  assets/css/style.css      | 10 +++++++---
>  index.html                | 36 ++++++++++++++++--------------------
>  4 files changed, 41 insertions(+), 27 deletions(-)

The carousel slider looks effective; also makes the page a little more
cleaner.  And I also noticed -- if I click on an image, conveniently
enough, the slider lets me rotate through the images manually as well.

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>    

> 
> diff --git a/_data/screenshots.yml b/_data/screenshots.yml
> index 3b8b6a5..2811244 100644
> --- a/_data/screenshots.yml
> +++ b/_data/screenshots.yml
> @@ -3,18 +3,28 @@
>    author: "Screenshot by [User:Nurnware](https://commons.wikimedia.org/wiki/User:Nurnware)"
>    description: "QEMU running the ReactOS operating system on Linux."
>    description_md: "QEMU running the [ReactOS](http://www.reactos.org) operating system on Linux."
> -- file: qemu-arm.png
> -  description: "QEMU running a 32-bit ARM binary on a 64-bit Linux system."
> +  heading: Full-system emulation
> +  blurb: Run operating systems for any machine, on any supported architecture
>  - file: qemu-advent-calendar-osv-redis.png
>    source: http://www.qemu-advent-calendar.org/#day-11
>    author: "Courtesy of Dor Laor"
>    description: "The dashboard of the OSv operating system, running in the background as a QEMU/KVM process."
>    description_md: "The dashboard of the [OSv](http://osv.io) operating system, running in the background as a QEMU/KVM process."
> +  heading: Virtualization
> +  blurb: Run KVM and Xen virtual machines with near native performance
> +- file: qemu-arm.png
> +  description: "QEMU running a 32-bit ARM binary on a 64-bit Linux system."
> +  heading: User-mode emulation
> +  blurb: Run programs for another Linux/BSD target, on any supported architecture
>  - file: qemu-advent-calendar-s390-moon-buggy.png
>    source: http://www.qemu-advent-calendar.org/#day-22
>    author: "Courtesy of Alexander Graf"
>    description: "QEMU emulating an ASCII art game for the System z (s390) mainframe."
> +  heading: Full-system emulation
> +  blurb: Run operating systems for non-native architectures
>  - file: qemu-advent-calendar-second-reality.png
>    source: http://www.qemu-advent-calendar.org/#day-13
>    author: "Courtesy of Paolo Bonzini"
>    description: "QEMU running Second Reality, a well-known PC demo from 1993, inside the FreeDOS operating system."
> +  heading: Full-system emulation
> +  blurb: Run demos written for classic / obsolete operating systems
> diff --git a/_includes/screenshot.html b/_includes/screenshot.html
> index 70b0d11..fb79e5d 100644
> --- a/_includes/screenshot.html
> +++ b/_includes/screenshot.html
> @@ -1,9 +1,13 @@
>  {% for screenshot in site.data.screenshots offset: {{include.offset}} limit: {{include.limit}} %}
> -<a href="screenshots/{{screenshot.file}}" class="colorbox"
> +<section>
> +  {% if screenshot.heading %}<h3>{{ screenshot.heading }}</h3>{% endif %}
> +  <div class="pennant"><a href="screenshots/{{screenshot.file}}" class="colorbox"
>     title="{{screenshot.description}}"
>     data-title="{% if screenshot.description_md %}{{screenshot.description_md | markdownify | remove: '<p>' | remove: '</p>' | strip_newlines | escape}}{%
>     else %}{{screenshot.description}}{%endif %}{%
>     if screenshot.author %} {{screenshot.author | markdownify | remove: '<p>' | remove: '</p>' | strip_newlines | escape}} {% endif %}{%
>     if screenshot.source %} (&lt;a href=&quot;{{screenshot.source}}&quot;&gt;Source&lt;/a&gt;){%endif %}"><img
> -   src="screenshots/{{screenshot.file}}" alt="Screenshot: {{screenshot.description}}"/></a>
> +   src="screenshots/{{screenshot.file}}" alt="Screenshot: {{screenshot.description}}"/></a></div>
> +  {% if screenshot.blurb %}<p>{{ screenshot.blurb }}</p>{% endif %}
> +</section>
>  {% endfor %}
> diff --git a/assets/css/style.css b/assets/css/style.css
> index e09b383..855217b 100644
> --- a/assets/css/style.css
> +++ b/assets/css/style.css
> @@ -557,13 +557,14 @@
>  	#featured header
>  	{
>  		border-bottom: 1px solid #333333;
> +		margin-bottom: 0.5em;
>  	}
>  	#featured h2
>  	{
>  		margin-bottom: 0em;
>  	}
>  
> -	#featured h3
> +	#featured .screenshots h3
>  	{
>  		padding: 1.5em 0em;
>  		font-size: 1.6em;
> @@ -573,12 +574,15 @@
>  		margin: 0em 0em 1em 0em;
>  	}
>  
> -	#featured .pennant
> +	#featured .screenshots .pennant
>  	{
>  		font-size: 4em;
> +		width: 40%;
> +		margin-left: auto;
> +		margin-right: auto;
>  	}
>  
> -	#featured .pennant img
> +	#featured .screenshots .pennant img
>  	{
>  		width: 100%;
>  		object-fit: contain;
> diff --git a/index.html b/index.html
> index e52868d..48304c8 100644
> --- a/index.html
> +++ b/index.html
> @@ -2,6 +2,7 @@
>  title: QEMU
>  layout: home
>  colorbox: True
> +bxslider: True
>  ---
>  {% include relative_root.html %}
>  	<!-- Header -->
> @@ -19,25 +20,9 @@ colorbox: True
>  			<h2>What is QEMU?</h2>
>  			<p>QEMU is a generic and open source machine emulator and virtualizer.</p>
>  		</header>
> -		<div class="row">
> -			<section class="4u">
> -				<div class="pennant">{% include screenshot.html offset=0 limit=1 %}</div>
> -				<h3>Full-system<br class="only-desktop"> emulation</h3>
> -				<p>Run operating systems for any machine, on any supported architecture</p>
> -			</section>
> -			<section class="4u">
> -				<div class="pennant">{% include screenshot.html offset=1 limit=1 %}</div>
> -				<h3>User-mode<br class="only-desktop"> emulation</h3>
> -				<p>Run programs for another Linux/BSD target, on any supported architecture</p>
> -			</section>
> -			<section class="4u">
> -				<div class="pennant">{% include screenshot.html offset=2 limit=1 %}</div>
> -				<h3>Virtualization</h3>
> -				<p>Run KVM and Xen virtual machines with near native performance</p>
> -			</section>
> -			<section style="display: none;">
> -			{% include screenshot.html offset=3 limit=10 %}
> -			</section>
> +		<div class="row slider screenshots">
> +			{% include screenshot.html %}
> +		</div>
>  
>  <script src="{{ relative_root }}/assets/js/object-fit.js"></script>
>  <script>
> @@ -59,9 +44,20 @@ $(window).on("load resize", function() {
>  $('.colorbox').on("click.random-namespace", function() {
>      return window.hasColorBox;
>  })
> +
> +$(document).ready(function(){
> +    $('.slider').bxSlider({
> +        auto: true,
> +        autoHover: true,
> +        mode: "fade",
> +        infiniteLoop: true,
> +        controls: false,
> +        speed: 500,
> +        pause: 5000,
> +    });
> +});
>  </script>
>  
> -		</div>
>  		<hr>
>  		<p>QEMU is a member of <a href="{{ relative_root }}/conservancy/">Software Freedom Conservancy</a>.</p>
>  	</div>
> -- 
> 2.26.2
> 
> 

-- 
/kashyap


