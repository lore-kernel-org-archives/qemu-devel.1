Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5328C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE9C2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BijeItb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhH55-0005Iz-VW
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhH3e-0003MR-O0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:27:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhH3d-0006mP-39
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591381627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+B8DoCKiyeuDsNQv5s0sIOLEcbNJMud2G9Thb99Jac=;
 b=BijeItb9EuQjtQmTUVvLJVijsgoBZaSiUXUGDcHl417FI922KitIT+krjRELdYB5xiNskJ
 fu8M1IsB7yT9UmgBPdY/sQ2dvov2VGtCs8XVRIuwX8Fb64hKpdcQY+5DH/ZxpxEgJTakQ4
 XdgB4t/cmdMYPGixwFksOHc9sFB4Gf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-cAUzpADFMsOGIW9-w7TTig-1; Fri, 05 Jun 2020 14:27:05 -0400
X-MC-Unique: cAUzpADFMsOGIW9-w7TTig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC93107ACCA;
 Fri,  5 Jun 2020 18:27:04 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD8F1972B;
 Fri,  5 Jun 2020 18:27:02 +0000 (UTC)
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <87bllx4igz.fsf@linaro.org> <535cf85f-96d7-0e98-c69e-c09b976bc251@linaro.org>
 <CAFEAcA88+W6PR2K5rmov7fM9+vyCuWW9u3mxg=61B1r9kYQT2g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5aafc164-a4e7-d3be-8922-5f98d767a97d@redhat.com>
Date: Fri, 5 Jun 2020 13:26:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88+W6PR2K5rmov7fM9+vyCuWW9u3mxg=61B1r9kYQT2g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 1:09 PM, Peter Maydell wrote:

> If there's an ordering requirement here we should make it clearer,
> or somebody is going to do the obvious "tidying up" at some point
> in the future.
> 
> Perhaps this whole set of lines should be rearranged, something like:
> 
> # Enable these warnings if the compiler supports them:
> warn_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
> warn_flags="-Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers $warn_flags"
> warn_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $warn_flags"
> warn_flags="-Wendif-labels -Wexpansion-to-defined $warn_flags"
> # Now disable sub-types of warning we don't want but which are
> # enabled by some of the warning flags we do want; these must come
> # later in the compiler command line than the enabling warning options.
> nowarn_flags="-Wno-missing-include-dirs -Wno-shift-negative-value"
> nowarn_flags="-Wno-initializer-overrides $nowarn_flags"
> nowarn_flags="-Wno-string-plus-int -Wno-typedef-redefinition $nowarn_flags"
> warn_flags="$warn_flags $nowarn_flags"
> 
> (is there a nicer shell idiom for creating a variable that's
> a long string of stuff without having over-long lines?)

You could always do:

# Append $2 into the variable named $1, with space separation
add_to () {
     eval $1=\${$1:+\"\$$1 \"}\$2
}

add_to warn_flags -Wold-style-declaration
add_to warn_flags -Wold-style-definition
add_to warn_flags -Wtype-limits
...
add_to nowarn_flags -Wno-string-plus-int
add_to nowarn_flags -Wno-typedef-redefinition
warn_flags="$warn_flags $nowarn_flags"

> 
> It's also tempting to pull the handful of warning related
> options currently set directly in QEMU_CFLAGS (-Wall, etc) into
> this same set of variables.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


