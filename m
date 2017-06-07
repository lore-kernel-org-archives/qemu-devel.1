Received: from eggs.gnu.org ([2001:4830:134:3::10]:58243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIdnB-0000PS-SQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIdn7-0002U6-Ua
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIdn7-0002Ti-Ow
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:26:41 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495229390-18909-1-git-send-email-felipe@nutanix.com> (Felipe
	Franciosi's message of "Fri, 19 May 2017 22:29:50 +0100")
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 18:26:39 +0200
Message-ID: <871sqvepc0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Felipe Franciosi <felipe@nutanix.com> wrote:
> Currently, the throttle_thread_scheduled flag is reset back to 0 before
> sleeping (as part of the throttling logic). Given that throttle_timer
> (well, any timer) may tick with a slight delay, it so happens that under
> heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
> schedule a further cpu_throttle_thread() work item after the flag reset,
> but before the previous sleep completed. This results on the vCPU thread
> sleeping continuously for potentially several seconds in a row.
>
> The chances of that happening can be drastically minimised by resetting
> the flag after the sleep.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Paolo, I think that the analisys makes sense.

Should you pull this patch, or do you want me to pull it?

Thanks, Juan.
