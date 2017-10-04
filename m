Received: from eggs.gnu.org ([2001:4830:134:3::10]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqqn-00054k-Ay
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqqk-0004xx-50
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:05:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzqqj-0004wQ-Vu
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:05:02 -0400
Date: Wed, 4 Oct 2017 18:04:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004210459.GC4015@localhost.localdomain>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
	<1507111682-66171-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507111682-66171-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qom: add helper macro DEFINE_TYPES()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Oct 04, 2017 at 12:08:02PM +0200, Igor Mammedov wrote:
> DEFINE_TYPES() will help to simplify following routine patterns:
> 
>  static void foo_register_types(void)
>  {
>     type_register_static(&foo1_type_info);
>     type_register_static(&foo2_type_info);
>     ...
>  }
> 
>  type_init(foo_register_types)
> 
> or
> 
>  static void foo_register_types(void)
>  {
>     int i;
> 
>     for (i = 0; i < ARRAY_SIZE(type_infos); i++) {
>         type_register_static(&type_infos[i]);
>     }
>  }
> 
>  type_init(foo_register_types)
> 
> with a single line
> 
>  DEFINE_TYPES(type_infos)
> 
> where types have static definition which could be consolidated in
> a single array of TypeInfo structures.
> It saves us ~6-10LOC per use case and would help to replace
> imperative foo_register_types() there with declarative style of
> type registration.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I will wait for 1 day or 2 before queueing it.

-- 
Eduardo
