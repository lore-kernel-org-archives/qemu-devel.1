Received: from eggs.gnu.org ([2001:4830:134:3::10]:53043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckyCV-00076M-O4
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckyCV-0002rw-1b
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:21:43 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ckyCU-0002rq-TM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:21:42 -0500
Received: by mail-qk0-x242.google.com with SMTP id o135so6213061qke.2
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 11:21:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87r32bif49.fsf@linaro.org>
	<09728335-6fd7-b332-0d86-91c0ded71d90@twiddle.net>
	<d2065d7a-c22f-2e61-3200-60f266610193@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0248703d-4145-090b-2b85-5dc1565668be@twiddle.net>
Date: Tue, 7 Mar 2017 06:21:34 +1100
MIME-Version: 1.0
In-Reply-To: <d2065d7a-c22f-2e61-3200-60f266610193@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, fred.konrad@greensocs.com, crosthwaite.peter@gmail.com

On 03/07/2017 03:58 AM, Paolo Bonzini wrote:
> On 06/03/2017 02:34, Richard Henderson wrote:
>> My guess is that everything from cpu_svm_check_intercept_param on should
>> be done from do_interrupt instead of during raise_interrupt.
>
>>From cpu_svm_check_intercept_param, or from cpu_vmexit?  The former seems
> to be too early because it will usually not even do anything, but treating
> cpu_vmexit like an exception is a very good idea indeed.  This is my
> uncompiled take.

I hadn't considered that approach.  But it looks very plausible.


r~
