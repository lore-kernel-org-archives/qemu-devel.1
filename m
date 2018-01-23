Received: from eggs.gnu.org ([2001:4830:134:3::10]:33526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edviu-0008Dg-IA
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edviq-0002ny-Gg
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:22:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:37672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1edviq-0002ni-9R
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:22:32 -0500
From: Andreas Schwab <schwab@suse.de>
References: <mvmk1w9lreq.fsf@suse.de>
	<7ee5ca93-da4e-c1e6-e534-6cc9b2f257b5@vivier.eu>
Date: Tue, 23 Jan 2018 11:22:30 +0100
In-Reply-To: <7ee5ca93-da4e-c1e6-e534-6cc9b2f257b5@vivier.eu> (Laurent
	Vivier's message of "Tue, 23 Jan 2018 01:35:10 +0100")
Message-ID: <mvmmv14ub6h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement renameat2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On Jan 23 2018, Laurent Vivier <laurent@vivier.eu> wrote:

> Please fix style problem reported by patchew
> (or ./scripts/checkpatch.pl)

This was mostly copy-pasted from surrounding code. :-)

>> @@ -8342,6 +8359,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>          }
>>          break;
>>  #endif
>> +#if defined(TARGET_NR_renameat2)
>> +    case TARGET_NR_renameat2:
>> +        {
>> +            void *p2;
>> +            p  = lock_user_string(arg2);
>> +            p2 = lock_user_string(arg4);
>> +            if (!p || !p2)
>> +                ret = -TARGET_EFAULT;
>> +            else
>> +                ret = get_errno(sys_renameat2(arg1, p, arg3, p2,
>> +                                              target_to_host_bitmask(arg5, fcntl_flags_tbl)));
>
> You can't use fcntl_flags_tbl

Of course!  I was confused by another patch I was working on which does
need such a conversion. :-/

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
