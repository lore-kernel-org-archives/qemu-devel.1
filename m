Received: from eggs.gnu.org ([2001:4830:134:3::10]:55196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzf69-0001QU-EO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzf1D-0001s1-Fb
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:31:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzf1D-0001rh-8Q
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:31:35 -0400
References: <20180820150903.1224-4-pbonzini@redhat.com>
	<000001d43ea0$02146ed0$063d4c70$@ru>
	<5b9a85eb-cefd-925c-b24b-95b93bbbfce8@redhat.com>
	<000a01d448c8$4a55c0e0$df0142a0$@ru>
	<ea5f162e-bd8a-001c-b78c-25378e3b2919@redhat.com>
	<001e01d44994$d02acb80$70806280$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8014c4f-f581-bdf9-c853-9ea1b8855726@redhat.com>
Date: Tue, 11 Sep 2018 11:31:31 +0200
MIME-Version: 1.0
In-Reply-To: <001e01d44994$d02acb80$70806280$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [3/4] cpus: protect TimerState writes with a
 spinlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: "'Emilio G . Cota'" <cota@braap.org>

On 11/09/2018 08:00, Pavel Dovgalyuk wrote:
> Thanks, that works. Here is the updated diff (stubs were added).
> Will you apply it?

Yes, thanks for the quick test!

Paolo
