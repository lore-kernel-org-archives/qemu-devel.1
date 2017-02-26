Received: from eggs.gnu.org ([2001:4830:134:3::10]:46686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ci23b-000397-Rr
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ci23b-0007Ae-0V
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:52:23 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:36012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ci23a-0007AI-S4
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:52:22 -0500
Received: by mail-oi0-x22b.google.com with SMTP id f192so10120326oic.3
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 08:52:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50cd1e34-deda-dc9b-2ce9-5c0cf09223cc@vivier.eu>
References: <20170225230416.9775-1-bobby.prani@gmail.com>
	<50cd1e34-deda-dc9b-2ce9-5c0cf09223cc@vivier.eu>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 26 Feb 2017 11:51:51 -0500
Message-ID: <CAJhHMCAn=VYK9kCi-OA6oYXB6az6udBiByCPdeR0ws1ak4+Syw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add signal handling support
 for x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Allan Wirth <awirth@akamai.com>

On Sun, Feb 26, 2017 at 7:29 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>> @@ -6421,11 +6597,13 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
>>          || defined(TARGET_NIOS2)
>>          /* These targets do not have traditional signals.  */
>>          setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>> -#else
>> +#elif !defined(TARGET_X86_64)
>>          if (sa->sa_flags & TARGET_SA_SIGINFO)
>>              setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>>          else
>>              setup_frame(sig, sa, &target_old_set, cpu_env);
>> +#else
>> +        setup_rt_frame(sig, sa, &k->info, &target_old_set, cpu_env);
>>  #endif
>
> You should just add the "defined(TARGET_X86_64)" on the "#if".
>

OK, I'll send a v3. Thanks!

-- 
Pranith
