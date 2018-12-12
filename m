Received: from eggs.gnu.org ([2001:4830:134:3::10]:54501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX7t0-0003Hs-SJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX7su-0000G9-Ug
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:01:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gX7sr-0000Dh-Pj
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:01:19 -0500
Date: Wed, 12 Dec 2018 17:01:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181212170110.GJ31033@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181211205346.11118-1-ehabkost@redhat.com>
	<20181211205346.11118-5-ehabkost@redhat.com>
	<c4bdc91b-3946-0345-bb57-f3e2e71b9ae3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4bdc91b-3946-0345-bb57-f3e2e71b9ae3@amd.com>
Subject: Re: [Qemu-devel] [PULL 4/4] i386: Add "stibp" flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Dec 12, 2018 at 04:57:42PM +0000, Lendacky, Thomas wrote:
> On 12/11/2018 02:53 PM, Eduardo Habkost wrote:
> > The STIBP flag may be supported by the host KVM module, so QEMU
> > can allow it to be configured manually, and it can be exposed to
> > guests when using "-cpu host".
> > 
> > No additional migration code is required because the whole
> > contents of spec_ctrl is already migrated in the "cpu/spec_ctrl"
> > section.
> > 
> > Corresponding KVM patch was submitted at:
> > https://lore.kernel.org/lkml/20181205191956.31480-1-ehabkost@redhat.com/
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > Message-Id: <20181210180250.31299-1-ehabkost@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 86a934d450..12f559b6af 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1042,7 +1042,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, "pconfig", NULL,
> >              NULL, NULL, NULL, NULL,
> > -            NULL, NULL, "spec-ctrl", NULL,
> > +            NULL, NULL, "spec-ctrl", "stibp",
> 
> I guess I missed this earlier. Is there a corresponding patch for the AMD
> STIBP bit (CPUID 0x80000008_EBX[15]) that is in KVM?

This Intel STIBP patch is one that many distros have carried downstream
since the flaw came to light.

I've not seen any equiv patch for AMD STIBP bit, in either QMEU or libvirt,
so guess that's a gap that needs filling.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
