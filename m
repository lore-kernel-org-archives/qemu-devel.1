Received: from eggs.gnu.org ([2001:4830:134:3::10]:48325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1etEXk-0006fc-AJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1etEXg-0002lV-Gb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:30:20 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1etEXg-0002ec-5m
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:30:16 -0500
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-4-git-send-email-abdallah.bouassida@lauterbach.com>
	<CAFEAcA88s2X9qkFVYG6kmeeZj6-bp0uskXb8TJF0HMfUVVSf8A@mail.gmail.com>
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <46c35ebb-b0f9-9a55-b8b1-cd94a29cff3e@lauterbach.com>
Date: Tue, 6 Mar 2018 16:29:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88s2X9qkFVYG6kmeeZj6-bp0uskXb8TJF0HMfUVVSf8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/4] target/arm: Add the XML dynamic
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

Hi Peter,
>> diff --git a/gdbstub.c b/gdbstub.c
>> index f1d5148..ffab30b 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -665,6 +665,9 @@ static const char *get_feature_xml(const char *p, const char **newp,
>>              pstrcat(target_xml, sizeof(target_xml), "<xi:include href=\"");
>>              pstrcat(target_xml, sizeof(target_xml), cc->gdb_core_xml_file);
>>              pstrcat(target_xml, sizeof(target_xml), "\"/>");
>> +            if (cc->gdb_has_dynamic_xml) {
>> +                cc->register_gdb_regs_for_features(cpu);
>> +            }
> I don't think we need a callback hook for this. You could just assume
> the target code has already done whatever it needs. Specifically for
> arm you can just make arm_cpu_register_gdb_regs_for_features() in helper.c
> call gdb_register_coprocessor(..., "system-registers.xml",...) the
> same way it already does for other xml files.
I think in this case, for ARM64, if the execution mode has changed (to AARCH32) the time we connect
to gdbstub then we will get the registers view of AARCH64 instead of AARCH32, as we have created
our XML at the beginning (on arm_cpu_register_gdb_regs_for_feature()) where the CPU is
on AARCH64.

Best regards,
Abdallah
