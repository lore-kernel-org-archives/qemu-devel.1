Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F005C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B5720663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B5720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLXd-0006tO-Ce
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35602)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiKiJ-0003qe-3u
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiKiH-0007jD-AJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:28:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiKiH-0007hn-2L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:28:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so18331727wrt.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kpm+FVcVGLC6WQ+TSkb4xsjH/RwO2EJz626KNut6Zfg=;
 b=QOuA+tQz3xGqWEWC5sPxkkiDZNVd16bjr7p2bEDUTWq8exG71cbl/sZyM9VO5mWBaN
 2YaaD3XuTdj8kKFXnA9nBUqT8XYHsIVVeyce6oBBMs/dqIEW6+raKL/4MeE/OihRqo5q
 p09wIA70SvFK3xyIg0l2OwUUNX4hk2yEw2NASXjeaBv03XRcmqaSGC7p4SEK2nF9l7Ay
 S5ie2sCLTq5z8FGXH8RIXYcXHBOoU4pa0Pyuscvd8FU91gsr7m47B31gCLFbbG2/C3Kv
 FnRWo2eeqgb/Xp3fbqs8yZPux+LtdP2sx2qFDUQZnWLcRDDjjKVbbWjoGKnsYxxYwpt1
 Pq6A==
X-Gm-Message-State: APjAAAWfDsYrWNdfqZ5CPR5OGLDfANpg4KhS76QZv7x+lNQVKjKKv1ex
 qNW2FIFryNsOm01W6162VLS2og==
X-Google-Smtp-Source: APXvYqxULK7YUIBsuHoqyjaZ74ITUiFetNaDBCMhQ/+J7xZ0dQOTdDTHw83s7qafJED4fD+7a0yj6w==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr10443007wrq.221.1562081335512; 
 Tue, 02 Jul 2019 08:28:55 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id s3sm3593192wmh.27.2019.07.02.08.28.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:28:54 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
 <0f46b807-1fcc-d5d6-9d62-601cc8dfa692@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e8b87bed-b7eb-d8bf-f011-e573b0737775@redhat.com>
Date: Tue, 2 Jul 2019 17:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0f46b807-1fcc-d5d6-9d62-601cc8dfa692@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 0/9] hw/block/pflash_cfi01: Add
 DeviceReset() handler
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair23@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 1:52 PM, Laszlo Ersek wrote:
> Hi Phil,
> 
> On 07/02/19 02:12, Philippe Mathieu-Daudé wrote:
>> The pflash device lacks a reset() function.
>> When a machine is resetted, the flash might be in an
>> inconsistent state, leading to unexpected behavior:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1678713
>> Resolve this issue by adding a DeviceReset() handler.
>>
>> Fix also two minor issues, and clean a bit the codebase.
>>
>> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00962.html
>> - addressed Laszlo review comments
>>
>> Maintainers spam list from:
>> ./scripts/get_maintainer.pl -f $(git grep -El '(pflash_cfi01_register|TYPE_PFLASH_CFI01)')
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (9):
>>   hw/block/pflash_cfi01: Removed an unused timer
>>   hw/block/pflash_cfi01: Use the correct READ_ARRAY value
>>   hw/block/pflash_cfi01: Extract pflash_mode_read_array()
>>   hw/block/pflash_cfi01: Start state machine as READY to accept commands
>>   hw/block/pflash_cfi01: Add the DeviceReset() handler
>>   hw/block/pflash_cfi01: Simplify CFI_QUERY processing
>>   hw/block/pflash_cfi01: Improve command comments
>>   hw/block/pflash_cfi01: Replace DPRINTF by qemu_log_mask(GUEST_ERROR)
>>   hw/block/pflash_cfi01: Hold the PRI table offset in a variable
>>
>>  hw/block/pflash_cfi01.c | 140 +++++++++++++++++++++-------------------
>>  hw/block/trace-events   |   1 +
>>  2 files changed, 74 insertions(+), 67 deletions(-)
>>
> 
> I'll do some regression-tests with this, using OVMF and ArmVirtQemu.

My local tree is larger with many tracing improvments, but I stripped
that part to keep this series short and bugfix oriented.

I used the trace logs to analyse the guest accesses.

My test setup is not yet automatized but I'm working on passing all the
one working with TCG as Avocado tests.

Tests machines (firmwares):

- ARM Verdex with (U-Boot)
- MIPS Malta with (Linux)
- LM32 Milkymist One (RTEMS)
- X86 (EDK2 OVMF)

Each guest has different driver, thus use this device quite differently.

What I want to add to this list is:

- AARCH64 Virt (EDK2 ArmVirtQemu)

Because it uses another driver (not the OVMF one).

> I don't think I can usefully review the patches without getting lost in
> the related spec(s), and I don't have capacity for that.
> 
> Until I have regression test results, one question: are the changes to
> the device model transparent with regard to migration? (You are not
> introducing any compat properties.)

Good point.

Two fields updated are migrated:

static const VMStateDescription vmstate_pflash = {
    .name = "pflash_cfi01",
    .version_id = 1,
    .minimum_version_id = 1,
    .post_load = pflash_post_load,
    .fields = (VMStateField[]) {
        ...
        VMSTATE_UINT8(cmd, PFlashCFI01),
        VMSTATE_UINT8(status, PFlashCFI01),
        ...
        VMSTATE_END_OF_LIST()
    }
};

- status: should not break anything

- cmd:

  If migrated during cmd == READ_ARRAY state:

  Guest is saved with older QEMU having cmd=READ_ARRAY=0x00

  Guest restored to newer QEMU expecting READ_ARRAY=0xff

  - If the guest do a READ access, we are [currently] fine:
  the 0x00 command hits the default case and falls through
  0xff.

    ('currently' because I have a local patch that would
     clean up this impossible case, but I made it possible).

  - If guest does WRITE access, again the 0x00 is processed
  by the default case where we jump to the error_flash label.
  There we log a warning and call pflash_mode_read_array().

  So this is not clean, but safe.

  To be clean I should document 0x00 was previously used and
  even not matching the specs, we have to live with handling
  it forever.



  A cleaner way to keep this safe and the code simple is to
  increment vmstate_pflash.version_id, and add a new case in
  the post_load handler:

static int pflash_post_load(void *opaque, int version_id)
{
    PFlashCFI01 *pfl = opaque;

    ... // current handler code

    if (version_id < 2) {
        /* version_id used 0x00 for READ_ARRAY */
        if (s->cmd == 0x00) {
            s->cmd =  0xff;
        }
    }
    return 0;
}

Since I'm new with migration, I Cc'd Dave to check :)

Thanks!

Phil.

