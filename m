Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690CCC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23E12085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ3ZmZOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23E12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvwz-00052e-S5
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNvvv-00047O-9j
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNvvs-0001zU-EW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601548527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=TqZZIbgJOY6jA7Ga5YB9Ltlo4lOgl3NxQXc1ekY5EZQ=;
 b=gQ3ZmZOnfKlzrk7F2e2W2lM/iFrdBv6zAXme1AnCqJv7j4tDf0mcLwHWAs5HVmNAz/4i3u
 NX3of0vJ4oAE8JGQuCoHfXlI8KeyI0p1dRYUFQMnd0uUM30IvPLBHIBkr9wjE55UuxQPaW
 Q/3ucHXnlRXrpsfABykK+wbTXhuNcVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-m-vlsI3aMNWR0wFdIHbvmg-1; Thu, 01 Oct 2020 06:35:26 -0400
X-MC-Unique: m-vlsI3aMNWR0wFdIHbvmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F12186DD2A;
 Thu,  1 Oct 2020 10:35:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCB3A5576E;
 Thu,  1 Oct 2020 10:35:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 55928113864A; Thu,  1 Oct 2020 12:35:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Use of "?" for help has been deprecated for 8 years, can we drop it?
Date: Thu, 01 Oct 2020 12:35:23 +0200
Message-ID: <87k0wa1bf8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We deprecated "?" more than eight years ago.  We didn't have a
deprecation process back then, but we did purge "?" from the
documentation and from help texts.  Can we finally drop it?

I'm asking because there is a patch on the list that bypasses
is_help_option() to not add deprecated "?" to a new place: "[PATCH v2
1/4] keyval: Parse help options".



commit c8057f951d64de93bfd01569c0a725baa9f94372
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Aug 2 13:45:54 2012 +0100

    Support 'help' as a synonym for '?' in command line options
    
    For command line options which permit '?' meaning 'please list the
    permitted values', add support for 'help' as a synonym, by abstracting
    the check out into a helper function.
    
    This change means that in some cases where we were being lazy in
    our string parsing, "?junk" will now be rejected as an invalid option
    rather than being (undocumentedly) treated the same way as "?".
    
    Update the documentation to use 'help' rather than '?', since '?'
    is a shell metacharacter and thus prone to fail confusingly if there
    is a single character filename in the current working directory and
    the '?' has not been escaped. It's therefore better to steer users
    towards 'help', though '?' is retained for backwards compatibility.
    
    We do not, however, update the output of the system emulator's -help
    (or any documentation autogenerated from the qemu-options.hx which
    is the source of the -help text) because libvirt parses our -help
    output and will break. At a later date when QEMU provides a better
    interface so libvirt can avoid having to do this, we can update the
    -help text too.
    
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
    Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

commit 585f60368f23e6603cf86cfdaeceb89d1169f4b8
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Oct 4 16:22:01 2012 +0100

    qemu-options.hx: Change from recommending '?' to 'help'
    
    Update the -help output and documentation so that it recommends
    'help' rather than '?' for the various "list valid values for this
    option" cases. '?' is deprecated (as it can fail confusingly if
    not quoted), so it's better to steer users towards 'help'. ('?'
    still works, for backwards compatibility.)
    
    This is the -help option part of the change otherwise done in
    commit c8057f9, since we are now past release 1.2 and free to
    change our help text without worrying about breaking libvirt.
    
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>


