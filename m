Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB44C352A5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A3120661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1MB4-0006Bd-9D
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 22:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1MAM-0005Ri-4P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1MAK-0005aA-EU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:24:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:30470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1j1MAK-0005M9-3m
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:24:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Feb 2020 19:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; 
 d="scan'208,217";a="221788901"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.249.174.64])
 ([10.249.174.64])
 by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 19:24:42 -0800
Subject: Re: [virtio-dev] [PATCH v2 5/5] virtio-mmio: MSI vector and event
 mapping
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
 <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
 <20200129051247-mutt-send-email-mst@kernel.org>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <4f2e205a-3066-f917-fdc6-e110f1d3bf62@linux.intel.com>
Date: Tue, 11 Feb 2020 11:24:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200129051247-mutt-send-email-mst@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------E0DF50F0F1B6F5FC0B1C724C"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------E0DF50F0F1B6F5FC0B1C724C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/29/2020 6:14 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 21, 2020 at 09:54:33PM +0800, Jing Liu wrote:
>> Bit 1 msi_sharing reported in the MsiState register indicates the mapping mode
>> device uses.
>>
>> Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per event and
>> fixed static vectors and events relationship. This fits for devices with a high interrupt
>> rate and best performance;
>> Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and events
>> dynamic mapping and fits for devices not requiring a high interrupt rate.

Thanks for reviewing! Sorry for the late reply.

For msi sharing/non-sharing mode, we are trying to define a rule that,

simply using 1 bit to indicate what device wants and what driver should 
do. Let me try to explain details.

If it's sharing mode (bit=1), it means device doesn't want vector per 
queue or a high interrupt rate.

Driver should meet such request.

So define that, device should support at least 2 msi vectors and driver 
should use

VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE commands

to map the configuration change/selected queue events.

In implementation, driver will detect the bit=1, turn to !per_vq_vector 
and map 1 vector for config

and 1 for all queues to meet the request. (Maybe we need restrict this 
in spec too.)

> It seems that sharing mode is a superset of non-sharing mode.

I think sharing mode is not a superset, because driver should not map 
1:1 which will go against

the request from device that it doesn't want 1:1 (non-sharing mode).

In other words, device chooses the way it wants, a high interrupt rate 
with 1:1 or not.

> Isn't that right? E.g. with sharing mode drivers
> can still avoid sharing if they like.
Drivers should not avoid msi sharing if that bit is 1.
> Maybe it should just be a hint to drivers whether to share
> interrupts,
The sharing mode bit is the hint to indicate whether to share interrupts. :)
> instead of a completely different layout?

Except the bit, no other different register layout is there for such 
feature.

Thanks!

Jing

>> diff --git a/msi-state.c b/msi-state.c
>> index b1fa0c1..d470be4 100644
>> --- a/msi-state.c
>> +++ b/msi-state.c
>> @@ -1,4 +1,5 @@
>>   le32 {
>>       msi_enabled : 1;
>> -    reserved : 31;
>> +    msi_sharing: 1;
>> +    reserved : 30;
>>   };
>> -- 
>> 2.7.4
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

--------------E0DF50F0F1B6F5FC0B1C724C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/29/2020 6:14 PM, Michael S.
      Tsirkin wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Tue, Jan 21, 2020 at 09:54:33PM +0800, Jing Liu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Bit 1 msi_sharing reported in the MsiState register indicates the mapping mode
device uses.

Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per event and
fixed static vectors and events relationship. This fits for devices with a high interrupt
rate and best performance;
Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and events
dynamic mapping and fits for devices not requiring a high interrupt rate.
</pre>
      </blockquote>
    </blockquote>
    <p>Thanks for reviewing! Sorry for the late reply. <br>
    </p>
    <p>For msi sharing/non-sharing mode, we are trying to define a rule
      that, <br>
    </p>
    <p>simply using 1 bit to indicate what device wants and what driver
      should do. Let me try to explain details.<br>
    </p>
    <p>If it's sharing mode (bit=1), it means device doesn't want vector
      per queue or a high interrupt rate.</p>
    <p>Driver should meet such request.</p>
    <p>So define that, device should support at least 2 msi vectors and
      driver should use <br>
    </p>
    <p><span class="fontstyle0">VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
        commands</span></p>
    <p><span class="fontstyle0"> to map the configuration
        change/selected queue events</span>.<br style=" font-style:
        normal; font-variant: normal; font-weight: normal;
        letter-spacing: normal; line-height: normal; orphans: 2;
        text-align: -webkit-auto; text-indent: 0px; text-transform:
        none; white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
        ">
    </p>
    <p>In implementation, driver will detect the bit=1, turn to
      !per_vq_vector and map 1 vector for config</p>
    <p> and 1 for all queues to meet the request. (Maybe we need
      restrict this in spec too.)<br>
    </p>
    <blockquote type="cite"
      cite="mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
It seems that sharing mode is a superset of non-sharing mode.</pre>
    </blockquote>
    <p>I think sharing mode is not a superset, because driver should not
      map 1:1 which will go against</p>
    <p>the request from device that it doesn't want 1:1 (non-sharing
      mode).</p>
    <p>In other words, device chooses the way it wants, a high interrupt
      rate with 1:1 or not.<br>
    </p>
    <blockquote type="cite"
      cite="mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
Isn't that right? E.g. with sharing mode drivers
can still avoid sharing if they like.</pre>
    </blockquote>
    Drivers should not avoid msi sharing if that bit is 1.<br>
    <blockquote type="cite"
      cite="mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
Maybe it should just be a hint to drivers whether to share
interrupts, </pre>
    </blockquote>
    The sharing mode bit is the hint to indicate whether to share
    interrupts. :)<br>
    <blockquote type="cite"
      cite="mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">instead of a completely different layout?</pre>
    </blockquote>
    <p>Except the bit, no other different register layout is there for
      such feature.</p>
    <p>Thanks!<br>
    </p>
    <p>Jing<br>
    </p>
    <blockquote type="cite"
      cite="mid:20200129051247-mutt-send-email-mst@kernel.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">diff --git a/msi-state.c b/msi-state.c
index b1fa0c1..d470be4 100644
--- a/msi-state.c
+++ b/msi-state.c
@@ -1,4 +1,5 @@
 le32 {
     msi_enabled : 1;
-    reserved : 31;
+    msi_sharing: 1;
+    reserved : 30;
 };
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------E0DF50F0F1B6F5FC0B1C724C--

