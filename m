Received: from eggs.gnu.org ([2001:4830:134:3::10]:44802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCC0V-0004Op-1A
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCC0Q-0007mv-Hp
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:10:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCC0O-0007aJ-Gr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 19:10:34 -0400
Received: by mail-pf1-x442.google.com with SMTP id 78-v6so8047711pfq.0
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 16:10:20 -0700 (PDT)
References: <20181013004034.6968-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9c32ea9-c689-a790-fe73-9bd8c06aa872@linaro.org>
Date: Mon, 15 Oct 2018 16:10:16 -0700
MIME-Version: 1.0
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/8] tests/vm: Improvements when KVM is
 not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 10/12/18 5:40 PM, Philippe Mathieu-Daudé wrote:
> Hi Fam,
> 
> Few patches I added while testing the VM tests without KVM access.
> I doubt many people want to suffer using TCG for VM testing, but
> it was handy to debug/support aarch64 VM tests.
> 
> Also this could be a useful TCG stress test...?
> 
> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg04084.html
> - use default args.jobs (Fam)
> - move kvm_available() to scripts/QEMU so it can be used by Avocado
> - do not use -smp 1
> - add a BaseVM::arch property to help cross vm testing
> 
> Since v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03411.html
> - rebased on master
> - added get_default_jobs (Fam)
> - dropped 'When using TCG, wait longer for a VM to start'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
