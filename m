Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gnc-00064l-VA
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gnX-0000vW-8f
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gnT-0000pr-Tx
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4-v6so6049850wrb.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:02:28 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-12-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c447fd45-89ce-0c50-ce19-e3fc806d9e8b@redhat.com>
Date: Wed, 3 Oct 2018 15:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/12] hostmem: add some properties
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/09/2018 09:59, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/hostmem-memfd.c |  9 +++++++++
>  backends/hostmem.c       | 14 ++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 1e20fe0ba8..789c8c3f87 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -144,14 +144,23 @@ memfd_backend_class_init(ObjectClass *oc, void *data)
>                                     memfd_backend_get_hugetlb,
>                                     memfd_backend_set_hugetlb,
>                                     &error_abort);
> +    object_class_property_set_description(oc, "hugetlb",
> +                                          "Use huge pages",
> +                                          &error_abort);
>      object_class_property_add(oc, "hugetlbsize", "int",
>                                memfd_backend_get_hugetlbsize,
>                                memfd_backend_set_hugetlbsize,
>                                NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "hugetlbsize",
> +                                          "Huge pages size (ex: 2M, 1G)",
> +                                          &error_abort);
>      object_class_property_add_bool(oc, "seal",
>                                     memfd_backend_get_seal,
>                                     memfd_backend_set_seal,
>                                     &error_abort);
> +    object_class_property_set_description(oc, "seal",
> +                                          "Seal growing & shrinking",
> +                                          &error_abort);
>  }
>  
>  static const TypeInfo memfd_backend_info = {
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 4908946cd3..1a89342039 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -397,27 +397,41 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_bool(oc, "merge",
>          host_memory_backend_get_merge,
>          host_memory_backend_set_merge, &error_abort);
> +    object_class_property_set_description(oc, "merge",
> +        "Mark memory as mergeable", &error_abort);
>      object_class_property_add_bool(oc, "dump",
>          host_memory_backend_get_dump,
>          host_memory_backend_set_dump, &error_abort);
> +    object_class_property_set_description(oc, "dump",
> +        "Set to 'off' to exclude from core dump", &error_abort);
>      object_class_property_add_bool(oc, "prealloc",
>          host_memory_backend_get_prealloc,
>          host_memory_backend_set_prealloc, &error_abort);
> +    object_class_property_set_description(oc, "prealloc",
> +        "Preallocate memory", &error_abort);
>      object_class_property_add(oc, "size", "int",
>          host_memory_backend_get_size,
>          host_memory_backend_set_size,
>          NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "size",
> +        "Size of the memory region (ex: 500M)", &error_abort);
>      object_class_property_add(oc, "host-nodes", "int",
>          host_memory_backend_get_host_nodes,
>          host_memory_backend_set_host_nodes,
>          NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "host-nodes",
> +        "Binds memory to the list of NUMA host nodes", &error_abort);
>      object_class_property_add_enum(oc, "policy", "HostMemPolicy",
>          &HostMemPolicy_lookup,
>          host_memory_backend_get_policy,
>          host_memory_backend_set_policy, &error_abort);
> +    object_class_property_set_description(oc, "policy",
> +        "Set the NUMA policy", &error_abort);
>      object_class_property_add_bool(oc, "share",
>          host_memory_backend_get_share, host_memory_backend_set_share,
>          &error_abort);
> +    object_class_property_set_description(oc, "share",
> +        "Mark the memory as private to QEMU or shared", &error_abort);
>  }
>  
>  static const TypeInfo host_memory_backend_info = {
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
