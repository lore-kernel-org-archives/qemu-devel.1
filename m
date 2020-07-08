Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1348AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB994206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuF87C7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB994206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIJa-0000OA-25
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtHyK-0002Lr-7f
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24873
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtHyH-00059X-ED
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=dn1/czU0/UCzLCJP4IVHGUJj7uEUr9UlMCmqkkAV4wM=;
 b=XuF87C7IGpDrM2u+UMRzISoRlj+LjfQB5xBOiLjHVCvB00gmPuws0zHLZgTMYKpohgHv2/
 fzp5vVosDKDuNEXLXgixHMuSxDSyiepARMfnuzl9OGlynfodX1amZk7jWVbBoScevJ2IE6
 y1d2lB9TwPK+Cy+wC/ui+7FxAvpAOOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-dwsQfr9jOz25ED7QdfVuZw-1; Wed, 08 Jul 2020 07:48:45 -0400
X-MC-Unique: dwsQfr9jOz25ED7QdfVuZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D48A380183C;
 Wed,  8 Jul 2020 11:48:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC3960C80;
 Wed,  8 Jul 2020 11:48:38 +0000 (UTC)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <477ce8e8-283e-6f3e-d3ed-c7f758eaebdb@redhat.com>
Date: Wed, 8 Jul 2020 13:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200708105353.GE3229307@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/2020 12.53, Daniel P. Berrangé wrote:
> On Wed, Jul 08, 2020 at 10:52:38AM +0100, Stefan Hajnoczi wrote:
[...]
>> With this in mind I propose moving qemu.org infrastructure to GitLab
>> incrementally. [...]

FWIW, I think moving the QEMU infrastructure zoo to GitLab is a very
good idea!

Daniel already mentioned most of the things that I had in mind after
reading your mail (well, actually he mentioned way more things that I
had in mind), but let me add some sentences below anyway...

>> 2. wiki.qemu.org is a MediaWiki instance. Account creation is a hurdle
>> to one-time or new contributors. It is unclear whether GitLab's wiki
>> is expressive enough for a lossless conversion of the existing QEMU
>> wiki. Any volunteers interested in evaluating the wiki migration would
>> be appreciated.
> 
> Yeah, this is a potentially big piece of work. We didn't finish this
> in libvirt either. Looking at the libvirt mediawiki though, I decided
> not todo a straight export/import of all content.
> A bunch of content was horribly out of date and needed deleting as
> it was irrelevant to anyone, or outright misleading wrt current state
> of the world.

Having done some clean-up work in the QEMU wiki in the past already, I
can only agree with Daniel. I don't think that we want a 1:1 conversion
of the existing Wiki, we should rather start from scratch and only
convert the important pages. Or should we really keep stuff like
https://wiki.qemu.org/Documentation/KQemu around?

Maybe we should also rather convert the important content into parts of
the main website instead, just like Daniel mentioned it.

Whichever way we choose, I volunteer to help here if my spare time permits.

>> 5. Issue tracking. Launchpad more or less works, but the login always
>> bothers me. If we move git repo hosting then it makes sense to do
>> issue tracking on GitLab too.
> 
> The big thing that always bothers me about launchpad is how easy it
> is to get confused between issues for QEMU upstream and issues for
> legacy releases in Ubuntu distro.

+1000 !

I was already thinking of suggesting to move the bug tracker to either
gitlab or github or anywhere else during next KVM forum, since it is
IMHO a real pain.

I've seen so many bugs that users tried to open against the downstream
Ubuntu QEMU package but ended up in the upstream tracker instead. Apart
from that, the Launchpad UI is partly really horrible in my eyes (for
example you never know which action will trigger an immediate change and
which needs to be confirmed by pressing a button). Additional many
developers don't have a Launchpad account, so bugs can not be assigned
properly and you just have to pray that people see the notification
e-mails on the mailing list.

> There is a question of what todo with existing bugs in launchpad.
> 
> Essentially three choices
> 
>  1. Move all the open bugs to gitlab
>  2. Move some relevant bugs to gitlab, but close outdated ones
>  3. Leave existing launchpad bugs but don't allow new ones filed

I think we could set most (outdated) bugs simply to "incomplete" with a
message saying that the reporter should open a new bug on Gitlab if
necessary. Then after 60 days, the "incomplete" bugs will expire (i.e.
auto-close).

 Thomas


