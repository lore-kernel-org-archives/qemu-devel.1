Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D73FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1ED20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC9h6Rpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1ED20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8vB4-0002tv-2A
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 20:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8vAO-0002RB-6f
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 20:44:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8vAL-0004g9-QT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 20:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597970660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKgtRjJopON4BjoUF5c+Ayp1tMjQFHH3/nu2d1rQDOk=;
 b=VC9h6RpwpVn59+mX8MppEIA+dEUWyDTO4jzYRQGjU3tL7WAdU7fy1GxW8AQqWNzVRd51cK
 rEuuqGRkzy6ojfcRuV5LXHOFXZyruvsY4VBkZ1a2HK129jO9wNMcJKqopqW5tA3/PSMt/k
 5UiFygT3s2TkVIJpk8jD+OWgL8Yn8x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-O4MZZCekMx6M7oyF_UVoEw-1; Thu, 20 Aug 2020 20:44:16 -0400
X-MC-Unique: O4MZZCekMx6M7oyF_UVoEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E0C801A9E;
 Fri, 21 Aug 2020 00:44:15 +0000 (UTC)
Received: from [10.3.114.63] (ovpn-114-63.phx2.redhat.com [10.3.114.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A167010013D0;
 Fri, 21 Aug 2020 00:44:14 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] iotests: Test node/bitmap aliases during migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-5-mreitz@redhat.com>
 <b1ab8e28-f5ad-1cde-a706-02e4b32e1a0a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d5800911-0068-8810-f7e0-ab2b10f949b2@redhat.com>
Date: Thu, 20 Aug 2020 19:44:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b1ab8e28-f5ad-1cde-a706-02e4b32e1a0a@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 20:37:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 10:49 AM, Vladimir Sementsov-Ogievskiy wrote:
> # MYPYPATH=../../python/ mypy 300
> 300:154: error: Item "None" of "Optional[Match[Any]]" has no attribute 
> "group"
> Found 1 error in 1 file (checked 1 source file)
> 
> - the only complain. Suggest a fix:
> 
> diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
> index c6d86b1dbc..0241903743 100755
> --- a/tests/qemu-iotests/300
> +++ b/tests/qemu-iotests/300
> @@ -148,11 +148,11 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>               result = vm.qmp('human-monitor-command',
>                               command_line='info migrate_parameters')
> 
> -            hmp_mapping = re.search(r'^block-bitmap-mapping:\r?(\n  
> .*)*\n',
> -                                    result['return'], flags=re.MULTILINE)
> +            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
> +                          result['return'], flags=re.MULTILINE)
> +            hmp_mapping = m.group(0).replace('\r', '') if m else None
> 
> -            self.assertEqual(hmp_mapping.group(0).replace('\r', ''),
> -                             self.to_hmp_mapping(mapping))
> +            self.assertEqual(hmp_mapping, self.to_hmp_mapping(mapping))
>           else:
>               self.assert_qmp(result, 'error/desc', error)

Thanks; I'll fold that in to v5.

> 
> ===
> 
> # flake8 300
> 300:24:1: F401 'time' imported but unused
> 300:34:1: E302 expected 2 blank lines, found 1
> 300:42:67: E502 the backslash is redundant between brackets
> 300:47:67: E502 the backslash is redundant between brackets
> 300:67:53: E502 the backslash is redundant between brackets
> 300:122:9: E125 continuation line with same indent as next logical line
> 300:134:9: E125 continuation line with same indent as next logical line
> 300:185:52: E502 the backslash is redundant between brackets
> 300:186:72: E502 the backslash is redundant between brackets
> 300:285:77: E502 the backslash is redundant between brackets
> 300:305:77: E502 the backslash is redundant between brackets
> 300:306:78: E502 the backslash is redundant between brackets
> 300:330:77: E502 the backslash is redundant between brackets
> 300:350:77: E502 the backslash is redundant between brackets
> 300:385:57: E502 the backslash is redundant between brackets
> 300:386:59: E502 the backslash is redundant between brackets
> 300:387:67: E502 the backslash is redundant between brackets
> 300:412:78: E502 the backslash is redundant between brackets
> 300:425:78: E502 the backslash is redundant between brackets
> 300:435:78: E502 the backslash is redundant between brackets
> 300:436:76: E502 the backslash is redundant between brackets
> 300:451:66: E502 the backslash is redundant between brackets
> 300:473:78: E502 the backslash is redundant between brackets
> 300:474:79: E502 the backslash is redundant between brackets
> 300:488:78: E502 the backslash is redundant between brackets
> 300:489:77: E502 the backslash is redundant between brackets
> 
> - I post it just because ALE plugin in vim highlights all these things 
> for me. Up to you, I don't ask you to fix it.

Seems like an easy enough touchup to make.


>> +    def test_alias_on_both_migration(self) -> None:
>> +        src_map = self.mapping(self.src_node_name, 'node-alias',
>> +                               self.src_bmap_name, 'bmap-alias')
>> +
>> +        dst_map = self.mapping(self.dst_node_name, 'node-alias',
>> +                               self.dst_bmap_name, 'bmap-alias')
>> +
>> +        self.set_mapping(self.vm_a, src_map)
>> +        self.set_mapping(self.vm_b, dst_map)
>> +        self.migrate()
>> +        self.verify_dest_error(None)
> 
> Hmm, probably verify_dest_error() should be called from migrate(), as 
> you call it (almost) always after migrate()

This one I did not touch; it can be a followup patch if desired.

> 
>> +
>> +
> 
> [..]
> 
>> +    def test_unused_mapping_on_dst(self) -> None:
>> +        # Let the source not send any bitmaps
>> +        self.set_mapping(self.vm_a, [])
>> +
>> +        # Establish some mapping on the destination
>> +        self.set_mapping(self.vm_b, [])
> 
> Seems, you wanted to specify non-empty mapping for vm_b, yes?
> With any non-empty mapping here, just to better correspond to the comments:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> (or keep this case with both mappings empty, and add one similar with 
> empty mapping only on src)

Adding another case will now have to be a separate patch.  At any rate, 
I've taken the liberty of including your R-b in my staging tree for the 
pending pull request, let me know if I should drop it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


