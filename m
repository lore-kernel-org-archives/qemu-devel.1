Received: from eggs.gnu.org ([2001:4830:134:3::10]:59210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgns-0006B4-D4
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgno-0008VF-6L
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:25:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgnn-0008Uj-87
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:25:51 -0400
References: <20180903171831.15446-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f34ac355-a283-c927-9b61-2c824cdb91a3@redhat.com>
Date: Tue, 11 Sep 2018 13:25:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180903171831.15446-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] i386 + x86_64 mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 03/09/2018 19:18, Emilio G. Cota wrote:
> I sent ~20 days ago a series that allowed me to boot x86_64 with mttcg:
>   https://patchwork.kernel.org/cover/10564977/
> 
> Thanks to Paolo's work (already merged), we don't need to hold
> the BQL when calling cpu_get_ticks, which makes the MTTCG conversion
> even simpler. [ I have a couple more patches related to some of
> that work, but I'll send them next week once Paolo is back ]
> 
> This series enables MTTCG for both x86_64 and i386. I tested both
> with a buildroot image, and looked for races with Valgrind's helgrind.
> 
> The first four patches are not really necessary for i386 MTTCG,
> but since they'll eventually go via Paolo's tree I included them here.

Applied 3-4 for now.

Paolo
