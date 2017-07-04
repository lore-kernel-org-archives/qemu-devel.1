Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSOzy-0004ql-QP
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSOzu-0004fa-V8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:40:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSOzu-0004fK-OJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:40:14 -0400
Date: Tue, 4 Jul 2017 16:40:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170704164010.51a7afa2@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499177279-131407-7-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-7-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] s390x: return unavailable features via
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Tue,  4 Jul 2017 16:07:58 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> 
> The response for query-cpu-definitions didn't include the
> unavailable-features field, which is used by libvirt to figure
> out whether a certain cpu model is usable on the host.
> 
> The unavailable features are now computed by obtaining the host CPU
> model and comparing it against the known CPU models. The comparison
> takes into account the generation, the GA level and the feature
> bitmaps. In the case of a CPU generation/GA level mismatch
> a feature called "type" is reported to be missing.
> 
> As a result, the output of virsh domcapabilities would change
> from something like
>  ...
>      <mode name='custom' supported='yes'>
>       <model usable='unknown'>z10EC-base</model>
>       <model usable='unknown'>z9EC-base</model>
>       <model usable='unknown'>z196.2-base</model>
>       <model usable='unknown'>z900-base</model>
>       <model usable='unknown'>z990</model>
>  ...
> to
>  ...
>      <mode name='custom' supported='yes'>
>       <model usable='yes'>z10EC-base</model>
>       <model usable='yes'>z9EC-base</model>
>       <model usable='no'>z196.2-base</model>
>       <model usable='yes'>z900-base</model>
>       <model usable='yes'>z990</model>
>  ...
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Message-Id: <1499082529-16970-1-git-send-email-mihajlov@linux.vnet.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 62 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
