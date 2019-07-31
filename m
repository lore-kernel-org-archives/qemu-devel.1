Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BDC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EFA216C8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="bjOV4+Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EFA216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hslUv-0006kt-VR
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hslUT-00068f-ER
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hslUS-0003Gl-0w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:05:49 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:59690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hslUL-0003C9-Cm; Wed, 31 Jul 2019 06:05:41 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1D2F996F50;
 Wed, 31 Jul 2019 10:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564567539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A264x5ClUypgBWpVmQ8KWpvcamOfMY020oGf4ui6c6A=;
 b=bjOV4+Gproz5NyAxrjpnxW2+LVC42zwvjPjjI7R6iqUeGwP6ZdMjGID+55VyV5ZoRfp/Oz
 3XTYpsqFuWWNT3ZdOqdweWUSXslEpN7s+SW4Gb5Ml/KRpaCkVc10EuGH3jFV7i6JgA4YO6
 l1cYjC1THX2Fp8SUswU+AOnjflFR48I=
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
 <20190731063044.GG2032@umbus.fritz.box>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <00f40c0d-ecef-0310-201c-f2ac4a773258@greensocs.com>
Date: Wed, 31 Jul 2019 12:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190731063044.GG2032@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564567539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A264x5ClUypgBWpVmQ8KWpvcamOfMY020oGf4ui6c6A=;
 b=s3XLrBj5eCbSwifcpkg/Xt4fOIkIbFvMQ0L7IIhMuHOW/mJGfaqkuVQdE7rjC+fSFgPd27
 QVW4Zyepq8M2CWOCxhxOKFMrMOdhy/hNJA+P2HEEo39nMbvff2NtSCrriCL+Ycp8BvNrp4
 Cg8dvxFa6g6V3h173obPKLYIl3LEp2E=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564567539; a=rsa-sha256; cv=none;
 b=xjPQOjcQZguiBFljKK7R7MNFT8acgTQSAyV3Dj8WaVK48VjUS3XeSQny0+W2BT4aTrS7eL
 liDgYSWIUk5H1GoVcNf9NYGA31Gixgg4WfT8Z5hiWIpALpaMvOMLc6YxBLeHqxwPSdqCsJ
 597djsafcFRmIpwGhIIDOy5oTaJCbAo=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com, rth@twiddle.net,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/31/19 8:30 AM, David Gibson wrote:
> On Mon, Jul 29, 2019 at 04:56:30PM +0200, Damien Hedde wrote:
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  docs/devel/reset.txt | 165 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 165 insertions(+)
>>  create mode 100644 docs/devel/reset.txt
>>
>> diff --git a/docs/devel/reset.txt b/docs/devel/reset.txt
>> new file mode 100644
>> index 0000000000..c7a1eb068f
>> --- /dev/null
>> +++ b/docs/devel/reset.txt
>> @@ -0,0 +1,165 @@
>> +
>> +=====
>> +Reset
>> +=====
>> +
>> +The reset of qemu objects is handled using the Resettable interface declared
>> +in *include/hw/resettable.h*.
>> +As of now DeviceClass and BusClass implement this interface.
>> +
>> +
>> +Triggering reset
>> +----------------
>> +
>> +The function *resettable_reset* is used to trigger a reset on a given
>> +object.
>> +void resettable_reset(Object *obj, bool cold)
>> +
>> +The parameter *obj* must implement the Resettable interface.
> 
> And what happens if it doesn't?  This function has no way to report an
> error.

In the function, while retrieving the Resettable class, there is an
assert checking the obj is compatible. We could put an error argument
there to report that if that's preferable.
But then it means an error object should be given for every reset call.

> 
>> +The parameter *cold* is a boolean specifying whether to do a cold or warm
>> +reset
> 
> This doc really needs to explain the distinction between cold and warm
> reset.

ok

> 
>> +For Devices and Buses there is also the corresponding helpers:
>> +void device_reset(Device *dev, bool cold)
>> +void bus_reset(Device *dev, bool cold)
> 
> What's the semantic difference between resetting a bus and resetting
> the bridge device which owns it?

I can't speak for specific cases.
BusClass has already a reset method and qbus_reset_all is used as well
as qdev_reset_all in current code base. Currently both devices and buses
are used as reset entry point. I'm just keeping it that way.

> 
>> +If one wants to put an object into a reset state. There is the
>> +*resettable_assert_reset* function.
>> +void resettable_assert_reset(Object *obj, bool cold)
>> +
>> +One must eventually call the function *resettable_deassert_reset* to end the
>> +reset state:
>> +void resettable_deassert_reset(Object *obj, bool cold)
>> +
>> +Calling *resettable_assert_reset* then *resettable_deassert_reset* is the
>> +same as calling *resettable_reset*.
>> +
>> +It is possible to interleave multiple calls to
>> + - resettable_reset,
>> + - resettable_assert_reset, and
>> + - resettable_deassert_reset.
>> +The only constraint is that *resettable_deassert_reset* must be called once
>> +per *resettable_assert_reset* call so that the object leaves the reset state.
>> +
>> +Therefore there may be several reset sources/controllers of a given object.
>> +The interface handle everything and the controllers do not need to know
>> +anything about each others. The object will leave reset state only when all
>> +controllers released their reset.
>> +
>> +All theses functions must called while holding the iothread lock.
>> +
>> +
>> +Implementing reset for a Resettable object : Multi-phase reset
>> +--------------------------------------------------------------
>> +
>> +The Resettable uses a multi-phase mechanism to handle some ordering constraints
>> +when resetting multiple object at the same time. For a given object the reset
>> +procedure is split into three different phases executed in order:
>> + 1 INIT: This phase should set/reset the state of the Resettable it has when is
>> +         in reset state. Side-effects to others object is forbidden (such as
>> +         setting IO level).
>> + 2 HOLD: This phase corresponds to the external side-effects due to staying into
>> +         the reset state.
>> + 3 EXIT: This phase corresponds to leaving the reset state. It have both
>> +         local and external effects.
>> +
>> +*resettable_assert_reset* does the INIT and HOLD phases. While
>> +*resettable_deassert_reset* does the EXIT phase.
>> +
>> +When resetting multiple object at the same time. The interface executes the
>> +given phase of the objects before going to the next phase. This guarantee that
>> +all INIT phases are done before any HOLD phase and so on.
>> +
>> +There is three methods in the interface so must be implemented in an object.
>> +The methods corresponds to the three phases:
>> +```
>> +typedef void (*ResettableInitPhase)(Object *obj);
>> +typedef void (*ResettableHoldPhase)(Object *obj);
>> +typedef void (*ResettableExitPhase)(Object *obj);
>> +typedef struct ResettableClass {
>> +    InterfaceClass parent_class;
>> +
>> +    struct ResettablePhases {
>> +        ResettableInitPhase init;
>> +        ResettableHoldPhase hold;
>> +        ResettableExitPhase exit;
>> +    } phases;
>> +    [...]
>> +} ResettableClass;
>> +```
>> +
>> +Theses methods should be updated when specializing an object. For this the
>> +helper function *resettable_class_set_parent_reset_phases* can be used to
>> +backup parent methods while changing the specialized ones.
>> +void resettable_class_set_parent_reset_phases(ResettableClass *rc,
>> +                                              ResettableInitPhase init,
>> +                                              ResettableHoldPhase hold,
>> +                                              ResettableExitPhase exit,
>> +
>> +For Devices and Buses, some helper exists to know if a device/bus is under
>> +reset and what type of reset it is:
>> +```
>> +bool device_is_resetting(DeviceState *dev);
>> +bool device_is_reset_cold(DeviceState *dev);
> 
> It's not really clear to me when *_is_reset_cold() would be useful.

Useful only for devices/buses that have different cold/warm reset
behavior. In particular this should be used in the reset init phase.

Damien

