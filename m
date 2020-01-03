Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FECAC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDAC20866
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 13:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzZgrrtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDAC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inMoq-0004BZ-EA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 08:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inMnw-0003SU-Ug
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inMnu-0003lL-NU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:15:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20035
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inMnu-0003gI-Gg
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578057347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+FGUDGq0ZpxmmtWJouelkcM8+Mud4qJBz6fOMfNV3U=;
 b=bzZgrrtHVNN4mrzPmN0lCHGX1bJDLSGA269Lmk8auZ2lzjDjtTukYq4u+HwBGy5mxWmXox
 zFmJxiEkkoHxbtOTbKtcEbh8lXk3froeRyv0kZah6j1AILMUMT0K797i+CsDWc09gmv2eB
 my6sijPZ8DDSEXNjY4rTtH6m8wUcyR4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-QKHHOVuBNPyMuwuLnXTlfw-1; Fri, 03 Jan 2020 08:15:46 -0500
Received: by mail-wr1-f70.google.com with SMTP id o6so19155751wrp.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 05:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t7+UiKaujh7m+z6tUg7tSR7XiAM2bRMVIgWYi9iD/J0=;
 b=nRoLFevzmBgXE1mf3xDzv8Q85gM4G1OVCn17XDr7d8htH4bmYvCtbV2LhKjAi1DkDI
 EU0DsY1SeX1XojehUl/olSpJqMCJ/QHchtT4/Xns9HqHqni9mpkisnL4/KB7r1u/EEj4
 JYYOlelL7W/WTPtphy/vikZd2pTLBVm9G/VTPHyUZ8BzrEMsoALP6a4yRZYjs/sehs62
 h8twG1pqD+tUWIr+9fLXuoKO5k9iHgU2OPMsE5ka4Ei3lTn7VAZ484SUpIg9QlKSO+tO
 2DNbwu/BHTFJ26Rie5a85EJLDsUBX92bes/sO2UBN7lg7TqCsDAC7Fpg1PvarFWn3qSD
 i2fg==
X-Gm-Message-State: APjAAAVN/JrMAXvzjxEhOqltaIpZ3FEH9pmGu+pQ57HuBsJ7xNiTbU1o
 R2AihSkRZkx8h7261qD6vgQGYsxKvFzbK/USr5FTsMe7V+HI/7DxrlCCBkTWRwejvfTFDb6zr/9
 4qNp8eoILHDMpOu8=
X-Received: by 2002:adf:cf12:: with SMTP id o18mr89707777wrj.361.1578057344450; 
 Fri, 03 Jan 2020 05:15:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUFXKeQYo8wOgXLqFOmZALhMsePS7F98I2IzMRkRKHEdYezcjhv0Ho1K3kqRctpamKtpXzBA==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr89707744wrj.361.1578057344116; 
 Fri, 03 Jan 2020 05:15:44 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l15sm60624081wrv.39.2020.01.03.05.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 05:15:43 -0800 (PST)
Subject: Re: [PATCH 00/86] refactor main RAM allocation to use hostmem backend
To: Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <c2d1f51d-a204-ec82-1b0a-bf91161b819f@redhat.com>
 <20200103140657.23b143e4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <03669369-0511-039a-567c-8e4cfba21acf@redhat.com>
Date: Fri, 3 Jan 2020 14:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103140657.23b143e4@redhat.com>
Content-Language: en-US
X-MC-Unique: QKHHOVuBNPyMuwuLnXTlfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 1/3/20 2:06 PM, Igor Mammedov wrote:
> On Tue, 31 Dec 2019 16:58:10 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Hi Igor,
>>
>> On 12/31/19 2:02 PM, Igor Mammedov wrote:
>>> Series removes ad hoc RAM allocation API (memory_region_allocate_system=
_memory)
>>> and consolidates it around hostmem backend. It allows to
>>>    * resolve conflicts between global -mem-prealloc and hostmem's "poli=
cy" option
>>>      fixing premature allocation before binding policy is applied
>>>    * simplify complicated memory allocation routines which had to deal =
with 2 ways
>>>      to allocate RAM.
>>>    * it allows to reuse hostmem backends of a choice for main RAM witho=
ut adding
>>>      extra CLI options to duplicate hostmem features.
>>>      Recent case was -mem-shared, to enable vhost-user on targets that =
don't
>>>      support hostmem backends [1] (ex: s390)
>>>    * move RAM allocation from individual boards into generic machine co=
de and
>>>      provide them with prepared MemoryRegion.
>>>    * clean up deprecated NUMA features which were tied to the old API (=
see patches)
>>>       - "numa: remove deprecated -mem-path fallback to anonymous RAM"
>>>       - "numa: remove deprecated implicit RAM distribution between node=
s"
>>>       - "forbid '-numa node,mem' for 5.0 and newer machine types"
>>>
>>> Conversion introduces a new machine.ram-memdev property and wrapper cod=
e that
>>> aliases global -mem-path and -mem-alloc into automatically created host=
mem
>>> backend properties (provided ram-memdev was not set explicitly by user)=
.
>>> And then follows bulk of trivial patches that incrementally convert ind=
ividual
>>> boards to using machine.ram-memdev provided MemoryRegion.
>>>
>>> Board conversion typically involves:
>>>    * providing MachineClass::default_ram_size and MachineClass::default=
_ram_id
>>>      so generic code could create default backend if user didn't explic=
itly provide
>>>      ram-memdev or -m options
>>>    * dropping memory_region_allocate_system_memory() call
>>>    * using covinience MachineState::ram MemoryRegion, which points to M=
emoryRegion
>>>      allocated by ram-memdev
>>> On top of that for some boards:
>>>    * added missing ram_size checks (typically it were boards with fixed=
 ram size)
>>>    * ram_size fixups were replaced by checks and hard errors, forcing u=
ser to
>>>      provide correct "-m" values instead of ignoring it and continuing =
running.
>>>     =20
>>> After all boards are converted the old API is removed and memory alloca=
tion
>>> routines are cleaned up.
>>
>> I'm replying to the cover because multiple patches are concerned.
>>
>> Compiling arm/lm32/mips64el/ppc on 32-bit host I get:
> what host/gcc version are you building on,
> my fedora 30-32bit setup I did reproduce only a couple of errors.

I'm using the qemu:debian-win32-cross docker image from=20
tests/docker/dockerfiles/debian-win32-cross.docker:

$ i686-w64-mingw32.shared-gcc --version
i686-w64-mingw32.shared-gcc (GCC) 5.5.0

You can build the image running:

$ make docker-image-debian-win32-cross

>>
>>     CC      hw/arm/digic_boards.o
>> hw/arm/digic_boards.c: In function 'digic4_board_init':
>> hw/arm/digic_boards.c:57:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/digic_boards.o' failed
>> make: *** [hw/arm/digic_boards.o] Error 1
>>     CC      hw/arm/musicpal.o
>> hw/arm/musicpal.c: In function 'musicpal_init':
>> hw/arm/musicpal.c:1598:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/musicpal.o' failed
>> make: *** [hw/arm/musicpal.o] Error 1
>>     CC      hw/arm/nseries.o
>> hw/arm/nseries.c: In function 'n8x0_init':
>> hw/arm/nseries.c:1316:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/nseries.o' failed
>> make: *** [hw/arm/nseries.o] Error 1
>>     CC      hw/arm/omap_sx1.o
>> hw/arm/omap_sx1.c: In function 'sx1_init':
>> hw/arm/omap_sx1.c:119:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/omap_sx1.o' failed
>> make: *** [hw/arm/omap_sx1.o] Error 1
>>     CC      hw/arm/palm.o
>> hw/arm/palm.c: In function 'palmte_init':
>> hw/arm/palm.c:202:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/palm.o' failed
>> make: *** [hw/arm/palm.o] Error 1
>>     CC      hw/arm/collie.o
>> hw/arm/collie.c: In function 'collie_init':
>> hw/arm/collie.c:32:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/collie.o' failed
>> make: *** [hw/arm/collie.o] Error 1
>>     CC      hw/arm/mps2.o
>> hw/arm/mps2.c: In function 'mps2_common_init':
>> hw/arm/mps2.c:121:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/mps2.o' failed
>> make: *** [hw/arm/mps2.o] Error 1
>>     CC      hw/arm/mps2-tz.o
>> hw/arm/mps2-tz.c: In function 'mps2tz_common_init':
>> hw/arm/mps2-tz.c:391:22: error: format '%lli' expects argument of type
>> 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}'
>> [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/arm/mps2-tz.o' failed
>> make: *** [hw/arm/mps2-tz.o] Error 1
>>     CC      hw/lm32/lm32_boards.o
>> hw/lm32/lm32_boards.c: In function 'lm32_evr_init':
>> hw/lm32/lm32_boards.c:89:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> hw/lm32/lm32_boards.c: In function 'lm32_uclinux_init':
>> hw/lm32/lm32_boards.c:179:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/lm32/lm32_boards.o' failed
>> make: *** [hw/lm32/lm32_boards.o] Error 1
>>     CC      hw/lm32/milkymist.o
>> hw/lm32/milkymist.c: In function 'milkymist_init':
>> hw/lm32/milkymist.c:100:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>>     CC      hw/mips/mips_fulong2e.o
>> hw/mips/mips_fulong2e.c: In function 'mips_fulong2e_init':
>> hw/mips/mips_fulong2e.c:317:22: error: format '%ld' expects argument of
>> type 'long int', but argument 2 has type 'long long int' [-Werror=3Dform=
at=3D]
>>            error_report("Invalid RAM size, should be %ld", 256 * MiB);
>>                         ^
>> cc1: all warnings being treated as errors
>>     CC      hw/ppc/ppc405_boards.o
>> hw/ppc/ppc405_boards.c: In function 'ref405ep_init':
>> hw/ppc/ppc405_boards.c:165:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> hw/ppc/ppc405_boards.c: In function 'taihu_405ep_init':
>> hw/ppc/ppc405_boards.c:435:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/ppc/ppc405_boards.o' failed
>> make: *** [hw/ppc/ppc405_boards.o] Error 1
>>     CC      hw/ppc/ppc4xx_devs.o
>> hw/ppc/ppc4xx_devs.c: In function 'ppc4xx_sdram_adjust':
>> hw/ppc/ppc4xx_devs.c:704:39: error: format '%lli' expects argument of
>> type 'long long int', but argument 3 has type 'ram_addr_t {aka const
>> unsigned int}' [-Werror=3Dformat=3D]
>>                char *t =3D g_strdup_printf("%s%" PRIi64 "%s", s,
>> sdram_bank_sizes[i],
>>                                          ^
>> hw/ppc/ppc4xx_devs.c:709:22: error: format '%lli' expects argument of
>> type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned
>> int}' [-Werror=3Dformat=3D]
>>            error_report("Invalid RAM size, unable to fit all RAM into RA=
M
>> banks"
>>                         ^
>> cc1: all warnings being treated as errors
>> rules.mak:69: recipe for target 'hw/ppc/ppc4xx_devs.o' failed
>> make: *** [hw/ppc/ppc4xx_devs.o] Error 1
>>     CC      hw/ppc/e500.o
>> hw/ppc/e500.c: In function 'ppce500_init':
>> hw/ppc/e500.c:909:22: error: format '%ld' expects argument of type 'long
>> int', but argument 2 has type 'long long int' [-Werror=3Dformat=3D]
>>            error_report("RAM size must be multiple of %ld", RAM_SIZES_AL=
IGN);
>>                         ^
>> cc1: all warnings being treated as errors
>>
>>
>=20


