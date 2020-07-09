Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D0820772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj0UHCJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D0820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWLT-00038Z-UP
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtWKc-00021g-IQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:11:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31440
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtWKa-0000Pa-9m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594300275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ffdZ7ZoOr2DX7e8zvXO1aBvNuC0LpTsexbEx3L0VyIo=;
 b=gj0UHCJIU5BjCaLDtgmGe//VsQdiovXKi9kN67v7b2Gy0yUzv82Xo+KKHH9O36GaVfWJih
 PSZCR98Eje0pexaXbPIBDWRuPai807b5pxjyMOmMugyKUs83a4UBah4xXcFsSJ7Fz6ep4l
 3HfqypeEL6akYJYu1i7gUpSrj/rQuC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-6fbkWrAZP3KJCkcKHMKbyA-1; Thu, 09 Jul 2020 09:10:56 -0400
X-MC-Unique: 6fbkWrAZP3KJCkcKHMKbyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468D780BCB1;
 Thu,  9 Jul 2020 13:10:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 564202C24F;
 Thu,  9 Jul 2020 13:10:46 +0000 (UTC)
Subject: Delete some Wiki pages (was: Migrating custom qemu.org infrastructure
 to GitLab)
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
 <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4e5404a7-20dc-cb5d-6307-b66fae8f77a4@redhat.com>
Date: Thu, 9 Jul 2020 15:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 12.33, Paolo Bonzini wrote:
> On 09/07/20 12:22, Thomas Huth wrote:
>> FWIW, seems like we could use the "pandoc" tool to convert Mediawiki
>> (our old Wiki) to Markdown (Gitlab wiki). I've done a quick test and
>> converted https://wiki.qemu.org/Contribute/MailingLists into
>> https://gitlab.com/huth/qemu/-/wikis/Contribute/MailingLists with some
>> few clicks.
>>
>> But the longer I look at most Wiki pages, the more I think that we
>> should convert the important pages rather into a part of qemu-web
>> instead. I'll have a closer look and will suggest some patches when time
>> permits...
> 
> The wiki was cleaned up more or less at the same time as the
> qemu-web.git repo was created (actually as a prerequisite), it's
> actually not in a bad shape.

There are still quite a bit of pages that either contain hardly any
usable information or are completely outdated. Paolo, Stefan, may I ask
you to check whether the following pages could be deleted? I don't have
access rights to delete a page, so if you agree that they are mostly
useless, please go ahead and delete them:

- https://wiki.qemu.org/Features/40p :
  only few infos here, and 40p is merged already

- https://wiki.qemu.org/Features/PRePCleanup :
  prep machine was removed some time ago, 40p is the replacement

- https://wiki.qemu.org/Features/BeBox
  old project from 2010, never got merged AFAIK

- https://wiki.qemu.org/Features/Documentation/interop
  that has been superseded by:
  https://www.qemu.org/docs/master/interop/index.html

- https://wiki.qemu.org/Features/Documentation/specs
  that has been superseded by:
  https://www.qemu.org/docs/master/specs/index.html

- https://wiki.qemu.org/Features/DriveRefactoring
  Out of date, we've got -blockdev now (and not -blkdev)

- https://wiki.qemu.org/Features/LegacyRemoval
  Has been replaced by the "deprecated features" section in our docs

- https://wiki.qemu.org/Features/Machines/Edison
  old project from 2015, never took off AFAIK

- https://wiki.qemu.org/Features/LibvirtWiresharkDissector
  seems to be a libvirt proposal - IMHO should not be in the QEMU wiki

- https://wiki.qemu.org/Features/Tegra2
  old project, AFAIK never got merged

- https://wiki.qemu.org/Features/Version3.0
  Old suggestions for QEMU version 3.0 ... we're close to 5.1 already

- https://wiki.qemu.org/KeySigningParty2013
  https://wiki.qemu.org/KeySigningParty2014
  https://wiki.qemu.org/KeySigningParty2015
  Only some few old information here, useless nowadays?

- https://wiki.qemu.org/Features/network_reentrant
  Old ideas from 2013 ... I think vhost-net superseded this?

- https://wiki.qemu.org/Planning/Relicensing
  I think this has been completed. The page looks very outdated now.

- https://wiki.qemu.org/SecurityProcess
  Should be replaced with a redirect

 Thomas


