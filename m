Received: from eggs.gnu.org ([2001:4830:134:3::10]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsqLC-0005yi-TX
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsqLA-0000i5-0A
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:12:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fsqL9-0000hr-QE
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:11:59 -0400
Date: Thu, 23 Aug 2018 22:11:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180823141155.GD6960@lemon.usersys.redhat.com>
References: <20180823112153.15279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823112153.15279-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Increase timeout waiting for VM
 to boot to 5 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 08/23 12:21, Peter Maydell wrote:
> The VM tests currently have a timeout of 2 minutes for trying
> to connect to ssh. Since the guest VM has to boot from cold
> to the point of accepting inbound ssh during this time, if the
> host machine is heavily loaded it can spuriously time out.
> Increase the timeout from 2 to 5 minutes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Fam Zheng <famz@redhat.com>

Again, please apply this yourself. :)

Thanks,

Fam
