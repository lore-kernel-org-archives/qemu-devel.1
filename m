Received: from eggs.gnu.org ([2001:4830:134:3::10]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK0Tc-0004im-LK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK0TZ-0002h5-FX
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:29:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK0TY-0002bv-TW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:28:57 -0500
References: <20181106115351.9422-1-ppandit@redhat.com>
	<CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
	<BN6PR18MB122007CFC965C45DF2CA20BB9FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5127334b-e3c3-cf08-6855-8b6fd871cb5f@redhat.com>
Date: Tue, 6 Nov 2018 13:28:48 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR18MB122007CFC965C45DF2CA20BB9FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: li qiang <liq3ea@outlook.com>, Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 06/11/2018 13:27, li qiang wrote:
> The addr is 0~0x1fff, but when addr is at the near the end ,for example 
> 0x1fffe, the add>>2 can be 2047
> 
> and as script_ram is a uint32_t and so s->script_ram[addr >> 2] can read 
> out of the script_ram.

How so?  s->script_ram has size 2048, it's okay to access it at 2047.

Paolo
