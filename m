Received: from eggs.gnu.org ([2001:4830:134:3::10]:52414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDviO-00061j-A4
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDviN-00055Q-IQ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:34:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDviN-00055C-CJ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:34:19 -0400
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
	<869fcc91-40ff-97fa-2a82-ca34695ac864@redhat.com>
	<1867E709-8609-41BF-BB0A-3B851D9D984E@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <991eb981-1697-386b-6887-38eef28c5f60@redhat.com>
Date: Thu, 25 May 2017 18:34:15 +0200
MIME-Version: 1.0
In-Reply-To: <1867E709-8609-41BF-BB0A-3B851D9D984E@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 25/05/2017 18:25, Felipe Franciosi wrote:
> The perfect solution (for this throttling strategy) would probably be
> a per-cpu timer. In the meantime, I think avoiding massive sleeps is
> a win. We observed stalls in excess of 70 secs at 99% throttle.

Ah, so the issue is not overcommit, it's too high throttling.  Then it
makes sense.

Thanks,

Paolo

>> How overcommitted was the host system?
> Not overcommitted at all. And it's quite easy to reproduce. All you
> need is a workload heavy enough to prevent the migration from
> converging (or a slow network which you can emulate with a qdisc).
> 
> With a Linux guest, you should quickly see soft lockups being
> reported. With Windows, probably BSODs.
