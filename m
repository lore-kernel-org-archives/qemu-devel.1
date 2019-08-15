Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90ABC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE1F218C9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE1F218C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBSL-0000bn-OQ
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 04:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hyBRW-00006i-Mr
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hyBRV-00038G-Hw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:49:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hyBRS-00036n-W3; Thu, 15 Aug 2019 04:49:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5391F2D0FCE;
 Thu, 15 Aug 2019 08:49:06 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7946181768;
 Thu, 15 Aug 2019 08:49:01 +0000 (UTC)
Message-ID: <4c7435dac1f719c71da8b11eafd3d2a36f3bb8d8.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 11:49:00 +0300
In-Reply-To: <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <d0635a23-7f99-9cf7-500c-af668e8ca370@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 15 Aug 2019 08:49:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-14 at 16:08 -0500, Eric Blake wrote:
> On 8/14/19 3:22 PM, Maxim Levitsky wrote:
> 
> > This is an issue that was raised today on IRC with Kevin Wolf. Really thanks
> > for the idea!
> > 
> > We agreed that this new qmp interface should take the same options as
> > blockdev-create does, however since we want to be able to edit the encryption
> > slots separately, this implies that we sort of need to allow this on creation
> > time as well.
> > 
> > Also the BlockdevCreateOptions is a union, which is specialized by the driver name
> > which is great for creation, but for update, the driver name is already known,
> > and thus the user should not be forced to pass it again.
> > However qmp doesn't seem to support union type guessing based on actual fields
> > given (this might not be desired either), which complicates this somewhat.
> 
> Does the idea of a union type with a default value for the discriminator
> help?  Maybe we have a discriminator which defaults to 'auto', and add a
> union branch 'auto':'any'.  During creation, if the "driver":"auto"
> branch is selected (usually implicitly by omitting "driver", but also
> possible explicitly), the creation attempt is rejected as invalid
> regardless of the contents of the remaining 'any'.  But during amend
> usage, if the 'auto' branch is selected, we then add in the proper
> "driver":"xyz" and reparse the QAPI object to determine if the remaining
> fields in 'any' still meet the specification for the required driver branch.
> 
> This idea may still require some tweaks to the QAPI generator, but it's
> the best I can come up with for a way to parse an arbitrary JSON object
> with unknown validation, then reparse it again after adding more
> information that would constrain the parse differently.
> 

This could work, but the idea of doing the parsing twice might not be easy to implement.
We currently have the qmp parser completely separated from the rest of the qemu,
so only once the qmp command parsing is done, the corresponding callback is called.


I am thinking. Since any 'update' commmand would need to sepecify the node to work on,
one could add some kind of expression for the qmp frontend to query the driver of that
node itself, which would solve that problem


Something like that:

{ 'union': 'BlockdevAmendOptions',

  'base': {
      'node-name':         'str' },

  'discriminator': { 'get_block_driver(node-name)' } ,

  'data': {
      'file':           'BlockdevCreateOptionsFile',
      'gluster':        'BlockdevCreateOptionsGluster',
      'luks':           'BlockdevCreateOptionsLUKS',
      'nfs':            'BlockdevCreateOptionsNfs',
      'parallels':      'BlockdevCreateOptionsParallels',
      'qcow':           'BlockdevCreateOptionsQcow',
      'qcow2':          'BlockdevCreateOptionsQcow2',
      'qed':            'BlockdevCreateOptionsQed',
      'rbd':            'BlockdevCreateOptionsRbd',
      'sheepdog':       'BlockdevCreateOptionsSheepdog',
      'ssh':            'BlockdevCreateOptionsSsh',
      'vdi':            'BlockdevCreateOptionsVdi',
      'vhdx':           'BlockdevCreateOptionsVhdx',
      'vmdk':           'BlockdevCreateOptionsVmdk',
      'vpc':            'BlockdevCreateOptionsVpc'
  } }


The 'get_block_driver' expression will make the QMP frontend, take the value of the node-name union field,
and look up the block driver associated with it and use that as a discriminator.

Syntax wise we can (at some expense of readability) use json to express the same like

'discriminator': { 'field' : 'node-name', 'transform': 'getdrivername' },

Best regards,
	Maxim Levitsky


