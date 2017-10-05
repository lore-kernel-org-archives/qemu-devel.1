Received: from eggs.gnu.org ([2001:4830:134:3::10]:35751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e01F4-0007LK-BY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e01Ey-0005Q8-Nn
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e01Ey-0005P3-HG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:10:44 -0400
Date: Thu, 5 Oct 2017 10:10:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171005101041.5b039ab9@nial.brq.redhat.com>
In-Reply-To: <20171004210459.GC4015@localhost.localdomain>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
	<1507111682-66171-4-git-send-email-imammedo@redhat.com>
	<20171004210459.GC4015@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qom: add helper macro DEFINE_TYPES()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On Wed, 4 Oct 2017 18:04:59 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Oct 04, 2017 at 12:08:02PM +0200, Igor Mammedov wrote:
> > DEFINE_TYPES() will help to simplify following routine patterns:
> > 
> >  static void foo_register_types(void)
> >  {
> >     type_register_static(&foo1_type_info);
> >     type_register_static(&foo2_type_info);
> >     ...
> >  }
> > 
> >  type_init(foo_register_types)
> > 
> > or
> > 
> >  static void foo_register_types(void)
> >  {
> >     int i;
> > 
> >     for (i = 0; i < ARRAY_SIZE(type_infos); i++) {
> >         type_register_static(&type_infos[i]);
> >     }
> >  }
> > 
> >  type_init(foo_register_types)
> > 
> > with a single line
> > 
> >  DEFINE_TYPES(type_infos)
> > 
> > where types have static definition which could be consolidated in
> > a single array of TypeInfo structures.
> > It saves us ~6-10LOC per use case and would help to replace
> > imperative foo_register_types() there with declarative style of
> > type registration.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> I will wait for 1 day or 2 before queueing it.
Thanks!

I'll respin whole series with amended "foo: cleanup cpu type name composition"
patches due to s/type_init_from_array/DEFINE_TYPES/ change
