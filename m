Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD57C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D932072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D932072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwcg-00071T-KH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juwc3-0006LT-GA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:27:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:39730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juwc1-0000Wj-FL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:27:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D8286ADBD;
 Mon, 13 Jul 2020 11:27:08 +0000 (UTC)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Cornelia Huck <cohuck@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <d0bc3f23-98c0-eadb-55ed-3377f43c494a@suse.de>
 <20200710083356.4c6e9f78.cohuck@redhat.com>
 <c834b040-2365-4c6a-a301-553a1ede3e14@suse.de>
 <20200713125122.647232d0.cohuck@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <d00b0cbf-e698-5c09-d355-22a1ba3c624d@suse.de>
Date: Mon, 13 Jul 2020 13:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200713125122.647232d0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 00:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 12:51 PM, Cornelia Huck wrote:
> On Sat, 11 Jul 2020 13:40:50 +0200
> Claudio Fontana <cfontana@suse.de> wrote:
> 
>> I found out something that for me shows that more investigation here is warranted.
>>
>>
>> Here is my latest workaround for the problem:
>>
>>
>>
>> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
>> index 1e036cc602..47c9a015af 100644
>> --- a/hw/s390x/s390-skeys.c
>> +++ b/hw/s390x/s390-skeys.c
>> @@ -252,6 +252,8 @@ static const TypeInfo qemu_s390_skeys_info = {
>>      .class_size    = sizeof(S390SKeysClass),
>>  };
>>  
>> +extern void qemu_fflush(QEMUFile *f);
>> +
>>  static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>>  {
>>      S390SKeysState *ss = S390_SKEYS(opaque);
>> @@ -302,6 +304,7 @@ static void s390_storage_keys_save(QEMUFile *f, void *opaque)
>>      g_free(buf);
>>  end_stream:
>>      qemu_put_be64(f, eos);
>> +    qemu_fflush(f);
>>  }
>>  
>>  static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
>> ------------------------------------------------------------------------------------
>>
>>
>> I think that this might imply that my patch changing the migration stream has only triggered an existing problem.
> 
> Looks a bit like it.
> 
>>
>> The sympthom is: the load keys code does not see the EOS (byte value 1).
>> It does see the keys (which are all empty in the test, ie 32678 times the byte value 0). 
> 
> Yes, that (zero keys) is expected.
> 
>>
>> The workaround for the sympthom: flush the qemu file after putting the EOS in there.
>>
>>
>> Any ideas on where to investigate next?
> 
> Do any other users of the SaveVMHandlers interface see errors as well
> (or do they do the fflush dance)?
> 

Hi Cornelia,

just want to point you also to this discussion that I made outside of the context of this particular patch, with a much simpler reproducer:

https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg03969.html

There do not seem to be many users of the "Old style" vmstate_save as it is called in the code.

I could find only:

fgrep -R -- ".save_state"

hw/s390x/tod.c:    .save_state = s390_tod_save,
hw/s390x/s390-skeys.c:    .save_state = s390_storage_keys_save,
net/slirp.c:    .save_state = net_slirp_state_save,

It is difficult to see what does fflush where, and which methods are supposed to do what,
because we have quite a few methods in SaveVMHandlers and VMStateDescription.

Some of the fflushes are just done in the code just after writing the EOS,
and in some cases there is no fflush after writing the EOS, but there are other methods called at completion time as far as I understand, where the fflush is done.

The issue in the stream seems to appear only just after the s390 keys are written.

Maybe better to continue the discussion at: 

https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg03969.html

?
Otherwise it is fine, I can follow two threads if you prefer so.

Thanks,

Claudio







