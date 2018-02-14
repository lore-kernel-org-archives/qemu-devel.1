Received: from eggs.gnu.org ([2001:4830:134:3::10]:42246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elsnR-00078o-9H
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elsnN-0006Yb-7D
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:52:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1elsnN-0006YP-19
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:52:05 -0500
Date: Wed, 14 Feb 2018 08:51:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180214085148.GD13644@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Feb 13, 2018 at 06:11:05PM -0600, Michael Roth wrote:
> This blog entry is intended as a follow-up to the original entry in
> January regarding Spectre/Meltdown and the proposed changes to address
> them in the upcoming 2.11.1 release.
> 
> This entry is meant to accompany the 2.11.1 release (planned for
> 2018-02-14) and document how to make use of the new options for
> various architectures.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> 
> The pseries/s390 bits have gotten some initial review (thanks Suraj/Christian),
> but it can definitely use some additional review on the x86 side of things.
> 
> Also, Peter if think anything extra should to be mentioned on the ARM side just
> let me know what to add.
> 
>  .../2018-02-14-qemu-2-11-1-and-spectre-update.md   | 180 +++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 _posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
> 
> diff --git a/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md b/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
> new file mode 100644
> index 0000000..7cdea59
> --- /dev/null
> +++ b/_posts/2018-02-14-qemu-2-11-1-and-spectre-update.md
> @@ -0,0 +1,180 @@

> +Please note that, as mentioned in the previous blog post, QEMU/KVM generally
> +has the same requirements as other unpriviledged processes running on the
> +host WRT Spectre/Meltdown mitigation.

Is this actually still considered accurate wrt the host QEMU ? I was under
the believe that life is more complicated for QEMU/KVM wrt Spectre and that
it will require more protection than other unpriv processes on the host in
some cases.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
