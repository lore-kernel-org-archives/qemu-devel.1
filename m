Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB0A208C9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB0A208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwCUA-0006G4-Ly
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 18:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jwCTP-0005is-F8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 18:35:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:10434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jwCTL-0001uT-8Z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 18:35:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B9DD674637F;
 Fri, 17 Jul 2020 00:35:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 85A50745702; Fri, 17 Jul 2020 00:35:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 841AA745712;
 Fri, 17 Jul 2020 00:35:10 +0200 (CEST)
Date: Fri, 17 Jul 2020 00:35:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: TB Cache size grows out of control with qemu 5.0
In-Reply-To: <871rlbwhlp.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2007170013020.78424@zero.eik.bme.hu>
References: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
 <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
 <CAATJJ0L2V5QgPHoJW25HrT1_4_YhZJOLS=jFdCU6+JkHFG_MbA@mail.gmail.com>
 <871rlbwhlp.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2130592759-1594938910=:78424"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 18:35:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2130592759-1594938910=:78424
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 16 Jul 2020, Alex Bennée wrote:
> Christian Ehrhardt <christian.ehrhardt@canonical.com> writes:
>> On Wed, Jul 15, 2020 at 5:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two
>>> following it.
>>
>> Thank you Zoltan for pointing out this commit, I agree that this seems to be
>> the trigger for the issues I'm seeing. Unfortunately the common CI host size
>> is 1-2G. For example on Ubuntu Autopkgtests 1.5G.
>> Those of them running guests do so in 0.5-1G size in TCG mode
>> (as they often can't rely on having KVM available).
>>
>> The 1G TB buffer + 0.5G actual guest size + lack of dynamic downsizing
>> on memory pressure (never existed) makes these systems go OOM-Killing
>> the qemu process.
>
> Ooops. I admit the assumption was that most people running system
> emulation would be doing it on beefier machines.
>
>> The patches indicated that the TB flushes on a full guest boot are a
>> good indicator of the TB size efficiency. From my old checks I had:
>>
>> - Qemu 4.2 512M guest with 32M default overwritten by ram-size/4
>> TB flush count      14, 14, 16
>> - Qemu 5.0 512M guest with 1G default
>> TB flush count      1, 1, 1
>>
>> I agree that ram/4 seems odd, especially on huge guests that is a lot
>> potentially wasted. And most environments have a bit of breathing
>> room 1G is too big in small host systems and the common CI system falls
>> into this category. So I tuned it down to 256M for a test.
>>
>> - Qemu 4.2 512M guest with tb-size 256M
>> TB flush count      5, 5, 5
>> - Qemu 5.0 512M guest with tb-size 256M
>> TB flush count      5, 5, 5
>> - Qemu 5.0 512M guest with 256M default in code
>> TB flush count      5, 5, 5
>>
>> So performance wise the results are as much in-between as you'd think from a
>> TB size in between. And the memory consumption which (for me) is the actual
>> current issue to fix would be back in line again as expected.
>
> So I'm glad you have the workaround.
>
>>
>> So on one hand I'm suggesting something like:
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -944,7 +944,7 @@ static void page_lock_pair(PageDesc **re
>>   * Users running large scale system emulation may want to tweak their
>>   * runtime setup via the tb-size control on the command line.
>>   */
>> -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
>> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256 * MiB)
>
> The problem we have is any number we pick here is arbitrary. And while
> it did regress your use-case changing it again just pushes a performance
> regression onto someone else. The most (*) 64 bit desktop PCs have 16Gb
> of RAM, almost all have more than 8gb. And there is a workaround.
>
> * random number from Steams HW survey.
>
>>  #endif
>>  #endif
>>
>> OTOH I understand someone else might want to get the more speedy 1G
>> especially for large guests. If someone used to run a 4G guest in TCG the
>> TB Size was 1G all along.
>> How about picking the smaller of (1G || ram-size/4) as default?
>>
>> This might then look like:
>> --- a/accel/tcg/translate-all.c
>> +++ b/accel/tcg/translate-all.c
>> @@ -956,7 +956,12 @@ static inline size_t size_code_gen_buffe
>>  {
>>      /* Size the buffer.  */
>>      if (tb_size == 0) {
>> -        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
>> +        unsigned long max_default = (unsigned long)(ram_size / 4);
>> +        if (max_default < DEFAULT_CODE_GEN_BUFFER_SIZE) {
>> +            tb_size = max_default;
>> +        } else {
>> +           tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
>> +        }
>>      }
>>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>>          tb_size = MIN_CODE_GEN_BUFFER_SIZE;
>>
>> This is a bit more tricky than it seems as ram_sizes is no more
>> present in that context but it is enough to discuss it.
>> That should serve all cases - small and large - better as a pure
>> static default of 1G or always ram/4?
>
> I'm definitely against re-introducing ram_size into the mix. The
> original commit (a1b18df9a4) that broke this introduced an ordering
> dependency which we don't want to bring back.
>
> I'd be more amenable to something that took into account host memory and
> limited the default if it was smaller than a threshold. Is there a way
> to probe that that doesn't involve slurping /proc/meminfo?

I agree that this should be dependent on host memory size not guest 
ram_size but it might be tricky to get that value because different host 
OSes would need different ways. Maybe a new qemu_host_mem_size portability 
function will be needed that implements this for different host OSes. 
POSIX may or may not have sysconf _SC_PHYS_PAGES and _SC_AVPHYS_PAGES and 
linux has sysinfo but don't know how reliable these are.

Regards,
BALATON Zoltan
--3866299591-2130592759-1594938910=:78424--

