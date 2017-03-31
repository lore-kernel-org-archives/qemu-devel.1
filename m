Received: from eggs.gnu.org ([2001:4830:134:3::10]:49359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cttbJ-00059Z-3g
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cttbE-0002aj-6B
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:16:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cttbD-0002Zo-WB
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:16:08 -0400
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru> <87vaqs4dxc.fsf@linaro.org>
	<001b01d2a94a$fe5c46a0$fb14d3e0$@ru> <87o9wj3phd.fsf@linaro.org>
	<000901d2a9ff$89fcdad0$9df69070$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cef0aae5-e2ac-e510-0acd-cc424f59c603@redhat.com>
Date: Fri, 31 Mar 2017 12:16:00 +0200
MIME-Version: 1.0
In-Reply-To: <000901d2a9ff$89fcdad0$9df69070$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, =?UTF-8?Q?'Alex_Benn=c3=a9e'?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com



On 31/03/2017 11:16, Pavel Dovgalyuk wrote:
> 
> Do you think it would be worth including the dumper script I wrote in
> ./scripts/? I mainly wrote it to aid my understanding of the code flow
> but it might be useful in future investigations?

Yes, I think it is.  Alternatively, adding "-d rr" that dumps what is
recorded/replayed from the rr file would be useful.

Paolo
