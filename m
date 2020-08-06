Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B899EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5D222D00
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="rV09P/9a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eq2C3Jee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5D222D00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e4f-0007UF-P2
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1k3e1D-0008CI-0k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:25:07 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1k3e1A-0004AL-1k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:25:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 1FEFE14CF;
 Thu,  6 Aug 2020 07:25:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 06 Aug 2020 07:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type; s=fm3; bh=C7eSJoYZZFo7E7Ab8D47pp5OnV
 uwmbmagBFpNXRDV2U=; b=rV09P/9a2muknLcPeMyI4D9wE3bjnTniRuE6c+wDRB
 puNoJtzjyqIObh4C6sIX0gWG6jXR9yEgPnj0J02i6Wx6LL6YX6wjxTBNcxwQKJIT
 5rBD9nwhfDELDzBjR7dUNaMRp0Qfjscg9fE/e+xXT4NiuXl6IMMIdqwK5gF1sOfY
 k0EcH+e/Vn8K8IHoawJ00CDY8ZNqMCXntb0wpQQJcGUQjsrSOe5vdtItvA92LLIZ
 QBvX6O0XsVFsQwetTcbIMHcquroAAo4nyliYiSZ8oKKB6I9wQb8lTxoPI08K2ShY
 xdTvaz0QrU6IH0NbefBIWsaYxafDvGDuAMb/MZ28t1ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=C7eSJo
 YZZFo7E7Ab8D47pp5OnVuwmbmagBFpNXRDV2U=; b=Eq2C3JeeKHFYh6ZoVBpTSo
 bWYcuEnqzHnTa3yK5H6YZ2dNPQdl6POx7GND4ld8Z3QUCYaMCVqClcbkEzaBfuPy
 WH0nJZaL0LtlzJeZZxugboIkkdaM7wQWbaFUXpLhirf+Xu+5reChd4VB1e4moKUb
 yU58pc4ycuUcFVWous26HynGAB2ntTzmVGeIsGeIspsEY5uzEbmk41YPCqk2V4Oh
 4dNj+QW4bWQ7Xp4/ZtBhnIWVsmh4aHDgRGPV+8RmlcYnRPK4phfcp/oP8xc7iOVe
 ShVmDav8tIlHUpt3+VXolkpqqmz5jWmIU/Z5Im9mswpmR1y/AFHqqiTyHg+m+dEw
 ==
X-ME-Sender: <xms:jegrX7e5R2CHuEYmIUpsQlI2h8884cZdxhYHWxLYdZeFd6rtf7GgVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfggtgesthdtredttd
 dttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheq
 necuggftrfgrthhtvghrnhephfetudeftdejveegudejhfeuiefgjeehuddvtddvhfejte
 dufeelhfelhfeghfetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeg
 rddukeegrddvvdelrddvgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:jegrXxOZDp6ovz5dGuXaLqvBlQeMaAOxezMowqk4HzBWcTz_NZMYjg>
 <xmx:jegrX0iXoviHi0zAEjsV8_Hmy6UbLtNa1XSn_9FqonNPtkk4k21nfA>
 <xmx:jegrX8-FaBzlIY8b1r2MAJKOfA6UkqQCBYfZqWio1OC0RWVsau3BcA>
 <xmx:jegrX14EWwJDD0ByWzHfj-qyLIee2qwuc1jNrF10QSF1ppJaceRqCg>
Received: from x220.qyliss.net (p54b8e5f4.dip0.t-ipconnect.de [84.184.229.244])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2B8E030600A6;
 Thu,  6 Aug 2020 07:25:01 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 4058F39B; Thu,  6 Aug 2020 11:24:59 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost-user protocol feature negotiation
In-Reply-To: <20200806054622-mutt-send-email-mst@kernel.org>
References: <87sgd1ktx9.fsf@alyssa.is>
 <20200805181352-mutt-send-email-mst@kernel.org> <87lfis2lr6.fsf@alyssa.is>
 <20200806054622-mutt-send-email-mst@kernel.org>
Date: Thu, 06 Aug 2020 11:24:59 +0000
Message-ID: <87zh7810fo.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.20; envelope-from=hi@alyssa.is;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 07:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Aug 06, 2020 at 08:59:09AM +0000, Alyssa Ross wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Wed, Aug 05, 2020 at 03:13:06PM +0000, Alyssa Ross wrote:
>> >> Quoting from the definition of VHOST_USER_SET_PROTOCOL_FEATURES in
>> >> vhost-user.rst:
>> >> 
>> >> >   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is present in
>> >> >   ``VHOST_USER_GET_FEATURES``.
>> >> > 
>> >> > .. Note::
>> >> >    Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
>> >> >    this message even before ``VHOST_USER_SET_FEATURES`` was called.
>> >> 
>> >> To me, this could mean either of two things:
>> >> 
>> >> (1) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
>> >>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should enable the
>> >>     protocol features immediately.
>> >> 
>> >> (2) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
>> >>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should store those
>> >>     feature bits, but not actually consider them to be enabled until
>> >>     after VHOST_USER_SET_FEATURES has been received (presumably
>> >>     containing VHOST_USER_F_PROTOCOL_FEATURES).
>> >> 
>> >> The reason I bring this up is that QEMU appears to interpret it as (1),
>> >> while the vhost-user-net backend in Intel's cloud-hypervisor[1]
>> >> interprets it as (2).  So I'm looking for a clarification.
>> >> 
>> >> [1]: https://github.com/cloud-hypervisor/cloud-hypervisor
>> >> 
>> >> Thanks in advance.
>> >
>> >
>> > IMHO the intent was this: VHOST_USER_F_PROTOCOL_FEATURES bit in
>> > VHOST_USER_GET_FEATURES means that qemu can send
>> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
>> >
>> > With most feature bits in VHOST_USER_GET_FEATURES, the
>> > specific functionality needs to only be enabled after
>> > VHOST_USER_SET_FEATURES.
>> >
>> > However, this is for functionality dealing with guest activity.
>> > VHOST_USER_SET_PROTOCOL_FEATURES has nothing to do with guest directly,
>> > it's about negotiation between qemu and backend: it is only in
>> > VHOST_USER_GET_FEATURES for the reason that this is the only message
>> > (very) old backends reported.  Thus, the backend should not check
>> > whether VHOST_USER_SET_FEATURES sets VHOST_USER_F_PROTOCOL_FEATURES,
>> > instead it should simply always be ready to receive
>> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
>> >
>> > Backend that isn't always ready to handle
>> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES
>> > should not set VHOST_USER_F_PROTOCOL_FEATURES in
>> > VHOST_USER_GET_FEATURES.
>> 
>> Thanks for the explanation.  That matches what I had in mind with (1).
>> 
>> > This appears to be closer to (1), but if qemu can't distinguish
>> > then we don't care, right? For example, VHOST_USER_PROTOCOL_F_REPLY_ACK
>> > enables acks on arbitrary messages. Does the backend in question
>> > ignore the affected bit until SET_FEATURES? If yes won't this
>> > make qemu hang?
>> 
>> Yes.  That was my motivation for asking what the correct behaviour was,
>> so that I could fix the incorrect one. :)  I suspect that up to this point,
>> the cloud-hypervisor vhost-user-net backend has only been used with
>> cloud-hypervisor, and so this incompatibilty with QEMU was not noticed.
>> 
>> > How would you suggest clarifying the wording?
>> 
>> Do you think this communicates everything required?
>> 
>> ---
>> diff --git i/docs/interop/vhost-user.rst w/docs/interop/vhost-user.rst
>> index 10e3e3475e..72724d292a 100644
>> --- i/docs/interop/vhost-user.rst
>> +++ w/docs/interop/vhost-user.rst
>> @@ -854,9 +854,8 @@ Master message types
>>    ``VHOST_USER_GET_FEATURES``.
>>  
>>  .. Note::
>> -   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
>> -   support this message even before ``VHOST_USER_SET_FEATURES`` was
>> -   called.
>> +   ``VHOST_USER_F_PROTOCOL_FEATURES`` does not need to be acknowledged
>> +   with ``VHOST_USER_SET_FEATURES``.
>>  
>>  ``VHOST_USER_SET_PROTOCOL_FEATURES``
>>    :id: 16
>
> Hmm I find this confusing. I think it's a good policy to ask qemu to
> acknowledge it. It's just that the client should not wait for
> VHOST_USER_SET_FEATURES before handling VHOST_USER_SET_PROTOCOL_FEATURES
> or VHOST_USER_GET_PROTOCOL_FEATURES.

To me, it's confusing that a frontend is expected to ack
VHOST_USER_F_PROTOCOL_FEATURES even though the ack can't have any effect
(because VHOST_USER_GET_PROTOCOL_FEATURES and
VHOST_USER_SET_PROTOCOL_FEATURES both have to work even if the ack
hasn't been received yet).

But, if the frontend is supposed to ack anyway, how about:

Signed-off-by: Alyssa Ross <hi@alysas.is>

---
diff --git i/docs/interop/vhost-user.rst w/docs/interop/vhost-user.rst
index 10e3e3475e..bc78c9947f 100644
--- i/docs/interop/vhost-user.rst
+++ w/docs/interop/vhost-user.rst
@@ -854,9 +854,9 @@ Master message types
   ``VHOST_USER_GET_FEATURES``.
 
 .. Note::
-   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
-   support this message even before ``VHOST_USER_SET_FEATURES`` was
-   called.
+   While QEMU should acknowledge ``VHOST_USER_F_PROTOCOL_FEATURES``, a
+   backend must allow ``VHOST_USER_GET_PROTOCOL_FEATURES`` even if
+   ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been acknowledged yet.
 
 ``VHOST_USER_SET_PROTOCOL_FEATURES``
   :id: 16
@@ -869,8 +869,12 @@ Master message types
   ``VHOST_USER_GET_FEATURES``.
 
 .. Note::
-   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
-   this message even before ``VHOST_USER_SET_FEATURES`` was called.
+   While QEMU should acknowledge ``VHOST_USER_F_PROTOCOL_FEATURES``, a
+   backend must allow ``VHOST_USER_SET_PROTOCOL_FEATURES`` even if
+   ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been acknowledged yet.
+   The backend must not wait for ``VHOST_USER_SET_FEATURES`` before
+   enabling protocol features requested with
+   ``VHOST_USER_SET_PROTOCOL_FEATURES``.
 
 ``VHOST_USER_SET_OWNER``
   :id: 3

