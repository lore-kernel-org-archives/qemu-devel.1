Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA022070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCKPuWcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA022070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbeA1-0006Rx-1F
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbe9P-00061G-VU
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:53:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbe9P-0001Ae-6k
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590040430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=bD3s6MpZecjOXPaGJNh7LuEA1qePjogZXOQFbKyZSLE=;
 b=dCKPuWcwS1JBd9I+nLIr3tYJeM9bXlUb6Ft4k101mXbMnq7UoUNIE0PHSYkqHK6jMEG6vD
 wp3mkzQwQtU9oqukxbQOjC/eXZm8jhdtm+eMXhmvPck/GbZSBQChG0icAats8NfVMp1erb
 5pPx0uQr8AUmqJ4a8z4AHAQB5Cw8sCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-7sVRzJAZO62Ayj7jSZi2jg-1; Thu, 21 May 2020 01:53:48 -0400
X-MC-Unique: 7sVRzJAZO62Ayj7jSZi2jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B353F8014D4;
 Thu, 21 May 2020 05:53:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4797C82EEA;
 Thu, 21 May 2020 05:53:42 +0000 (UTC)
Subject: Re: [PATCH v2 6/9] pc-bios: s390x: Move panic() into header and add
 infinite loop
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9b36bd41-4fdf-ac1c-dcdd-37969d167ddd@redhat.com>
Date: Thu, 21 May 2020 07:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514123729.156283-7-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2020 14.37, Janosch Frank wrote:
> panic() was defined for the ccw and net bios, i.e. twice, so it's
> cleaner to rather put it into the header.
> 
> Also let's add an infinite loop into the assembly of disabled_wait() so
> the caller doesn't need to take care of it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c     | 7 -------
>  pc-bios/s390-ccw/netmain.c  | 8 --------
>  pc-bios/s390-ccw/s390-ccw.h | 9 +++++++--
>  pc-bios/s390-ccw/start.S    | 5 +++--
>  4 files changed, 10 insertions(+), 19 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


