Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE5FC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C09206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C09206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwbK-0002WI-2s
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iIwaQ-00026z-RR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iIwaN-00084t-AQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iIwaN-00084k-0t
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:12:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20CB510C092E;
 Fri, 11 Oct 2019 15:12:06 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 889B35C1B2;
 Fri, 11 Oct 2019 15:11:54 +0000 (UTC)
Subject: Re: [PATCH v6] migration: Support gtree migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191011121724.433-1-eric.auger@redhat.com>
 <20191011150112.GI18007@work-vm>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <15614b16-7047-b16e-f405-e12a2668b054@redhat.com>
Date: Fri, 11 Oct 2019 17:11:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191011150112.GI18007@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 11 Oct 2019 15:12:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/11/19 5:01 PM, Dr. David Alan Gilbert wrote:
> * Eric Auger (eric.auger@redhat.com) wrote:
>> Introduce support for GTree migration. A custom save/restore
>> is implemented. Each item is made of a key and a data.
>>
>> If the key is a pointer to an object, 2 VMSDs are passed into
>> the GTree VMStateField.
>>
>> When putting the items, the tree is traversed in sorted order by
>> g_tree_foreach.
>>
>> On the get() path, gtrees must be allocated using the proper
>> key compare, key destroy and value destroy. This must be handled
>> beforehand, for example in a pre_load method.
>>
>> Tests are added to test save/dump of structs containing gtrees
>> including the virtio-iommu domain/mappings scenario.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> I've applied:
> @@ -1070,8 +1070,8 @@ static gboolean match_domain_node(gpointer key, gpointer value, gpointer data)
>      TestGTreeDomain *d1, *d2;
>      struct match_node_data *d = (struct match_node_data *)data;
>  
> -    id1 = (uint64_t)key;
> -    id2 = (uint64_t)d->key;
> +    id1 = (uint64_t)(uintptr_t)key;
> +    id2 = (uint64_t)(uintptr_t)d->key;
>      d1 = (TestGTreeDomain *)value;
>      d2 = (TestGTreeDomain *)d->value;
>      assert(id1 == id2);
> 
> to get the tests happy in 32bit.
Thank you for taking care of this.

Eric
> 
>>
>> ---
>>
>> v4 -> v5:
>> - swap key/value in vmsd array
>> - fix g_free(key) in case of direct key
>> - return an error if the number of decoded nodes does not
>>   match nnodes
>>
>> v3 -> v4:
>> - properly initialize capsule.vmdesc in put_gtree()
>> - use uintptr_t
>> - add trace points
>>
>> v2 -> v3:
>> - do not include glib.h anymore
>> - introduce VMSTATE_GTREE_DIRECT_KEY_V
>> - use pre_load to allocate the tree and remove data pointer
>> - dump the number of nnodes and add checks on get path
>>
>> v1 -> v2:
>> - fix compilation issues reported by robots
>> - fixed init of VMSD array
>> - direct key now dumped as a 32b
>> - removed useless cast from/to pointer
>> ---
>>  include/migration/vmstate.h |  40 ++++
>>  migration/trace-events      |   5 +
>>  migration/vmstate-types.c   | 152 +++++++++++++
>>  tests/test-vmstate.c        | 421 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 618 insertions(+)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 1fbfd099dd..b9ee563aa4 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -224,6 +224,7 @@ extern const VMStateInfo vmstate_info_unused_buffer;
>>  extern const VMStateInfo vmstate_info_tmp;
>>  extern const VMStateInfo vmstate_info_bitmap;
>>  extern const VMStateInfo vmstate_info_qtailq;
>> +extern const VMStateInfo vmstate_info_gtree;
>>  
>>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
>>  /*
>> @@ -754,6 +755,45 @@ extern const VMStateInfo vmstate_info_qtailq;
>>      .start        = offsetof(_type, _next),                              \
>>  }
>>  
>> +/*
>> + * For migrating a GTree whose key is a pointer to _key_type and the
>> + * value, a pointer to _val_type
>> + * The target tree must have been properly initialized
>> + * _vmsd: Start address of the 2 element array containing the data vmsd
>> + *        and the key vmsd, in that order
>> + * _key_type: type of the key
>> + * _val_type: type of the value
>> + */
>> +#define VMSTATE_GTREE_V(_field, _state, _version, _vmsd,                       \
>> +                        _key_type, _val_type)                                  \
>> +{                                                                              \
>> +    .name         = (stringify(_field)),                                       \
>> +    .version_id   = (_version),                                                \
>> +    .vmsd         = (_vmsd),                                                   \
>> +    .info         = &vmstate_info_gtree,                                       \
>> +    .start        = sizeof(_key_type),                                         \
>> +    .size         = sizeof(_val_type),                                         \
>> +    .offset       = offsetof(_state, _field),                                  \
>> +}
>> +
>> +/*
>> + * For migrating a GTree with direct key and the value a pointer
>> + * to _val_type
>> + * The target tree must have been properly initialized
>> + * _vmsd: data vmsd
>> + * _val_type: type of the value
>> + */
>> +#define VMSTATE_GTREE_DIRECT_KEY_V(_field, _state, _version, _vmsd, _val_type) \
>> +{                                                                              \
>> +    .name         = (stringify(_field)),                                       \
>> +    .version_id   = (_version),                                                \
>> +    .vmsd         = (_vmsd),                                                   \
>> +    .info         = &vmstate_info_gtree,                                       \
>> +    .start        = 0,                                                         \
>> +    .size         = sizeof(_val_type),                                         \
>> +    .offset       = offsetof(_state, _field),                                  \
>> +}
>> +
>>  /* _f : field name
>>     _f_n : num of elements field_name
>>     _n : num of elements
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 858d415d56..6dee7b5389 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -71,6 +71,11 @@ get_qtailq_end(const char *name, const char *reason, int val) "%s %s/%d"
>>  put_qtailq(const char *name, int version_id) "%s v%d"
>>  put_qtailq_end(const char *name, const char *reason) "%s %s"
>>  
>> +get_gtree(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
>> +get_gtree_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, int ret) "%s(%s/%s) %d"
>> +put_gtree(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, uint32_t nnodes) "%s(%s/%s) nnodes=%d"
>> +put_gtree_end(const char *field_name, const char *key_vmsd_name, const char *val_vmsd_name, int ret) "%s(%s/%s) %d"
>> +
>>  # qemu-file.c
>>  qemu_file_fclose(void) ""
>>  
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index bee658a1b2..7236cf92bc 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -691,3 +691,155 @@ const VMStateInfo vmstate_info_qtailq = {
>>      .get  = get_qtailq,
>>      .put  = put_qtailq,
>>  };
>> +
>> +struct put_gtree_data {
>> +    QEMUFile *f;
>> +    const VMStateDescription *key_vmsd;
>> +    const VMStateDescription *val_vmsd;
>> +    QJSON *vmdesc;
>> +    int ret;
>> +};
>> +
>> +static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
>> +{
>> +    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
>> +    QEMUFile *f = capsule->f;
>> +    int ret;
>> +
>> +    qemu_put_byte(f, true);
>> +
>> +    /* put the key */
>> +    if (!capsule->key_vmsd) {
>> +        qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
>> +    } else {
>> +        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
>> +        if (ret) {
>> +            capsule->ret = ret;
>> +            return true;
>> +        }
>> +    }
>> +
>> +    /* put the data */
>> +    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
>> +    if (ret) {
>> +        capsule->ret = ret;
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +static int put_gtree(QEMUFile *f, void *pv, size_t unused_size,
>> +                     const VMStateField *field, QJSON *vmdesc)
>> +{
>> +    bool direct_key = (!field->start);
>> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[1];
>> +    const VMStateDescription *val_vmsd = &field->vmsd[0];
>> +    const char *key_vmsd_name = direct_key ? "direct" : key_vmsd->name;
>> +    struct put_gtree_data capsule = {
>> +        .f = f,
>> +        .key_vmsd = key_vmsd,
>> +        .val_vmsd = val_vmsd,
>> +        .vmdesc = vmdesc,
>> +        .ret = 0};
>> +    GTree **pval = pv;
>> +    GTree *tree = *pval;
>> +    uint32_t nnodes = g_tree_nnodes(tree);
>> +    int ret;
>> +
>> +    trace_put_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
>> +    qemu_put_be32(f, nnodes);
>> +    g_tree_foreach(tree, put_gtree_elem, (gpointer)&capsule);
>> +    qemu_put_byte(f, false);
>> +    ret = capsule.ret;
>> +    if (ret) {
>> +        error_report("%s : failed to save gtree (%d)", field->name, ret);
>> +    }
>> +    trace_put_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
>> +    return ret;
>> +}
>> +
>> +static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
>> +                     const VMStateField *field)
>> +{
>> +    bool direct_key = (!field->start);
>> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[1];
>> +    const VMStateDescription *val_vmsd = &field->vmsd[0];
>> +    const char *key_vmsd_name = direct_key ? "direct" : key_vmsd->name;
>> +    int version_id = field->version_id;
>> +    size_t key_size = field->start;
>> +    size_t val_size = field->size;
>> +    int nnodes, count = 0;
>> +    GTree **pval = pv;
>> +    GTree *tree = *pval;
>> +    void *key, *val;
>> +    int ret = 0;
>> +
>> +    /* in case of direct key, the key vmsd can be {}, ie. check fields */
>> +    if (!direct_key && version_id > key_vmsd->version_id) {
>> +        error_report("%s %s",  key_vmsd->name, "too new");
>> +        return -EINVAL;
>> +    }
>> +    if (!direct_key && version_id < key_vmsd->minimum_version_id) {
>> +        error_report("%s %s",  key_vmsd->name, "too old");
>> +        return -EINVAL;
>> +    }
>> +    if (version_id > val_vmsd->version_id) {
>> +        error_report("%s %s",  val_vmsd->name, "too new");
>> +        return -EINVAL;
>> +    }
>> +    if (version_id < val_vmsd->minimum_version_id) {
>> +        error_report("%s %s",  val_vmsd->name, "too old");
>> +        return -EINVAL;
>> +    }
>> +
>> +    nnodes = qemu_get_be32(f);
>> +    trace_get_gtree(field->name, key_vmsd_name, val_vmsd->name, nnodes);
>> +
>> +    while (qemu_get_byte(f)) {
>> +        if ((++count) > nnodes) {
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        if (direct_key) {
>> +            key = (void *)(uintptr_t)qemu_get_be64(f);
>> +        } else {
>> +            key = g_malloc0(key_size);
>> +            ret = vmstate_load_state(f, key_vmsd, key, version_id);
>> +            if (ret) {
>> +                error_report("%s : failed to load %s (%d)",
>> +                             field->name, key_vmsd->name, ret);
>> +                goto key_error;
>> +            }
>> +        }
>> +        val = g_malloc0(val_size);
>> +        ret = vmstate_load_state(f, val_vmsd, val, version_id);
>> +        if (ret) {
>> +            error_report("%s : failed to load %s (%d)",
>> +                         field->name, val_vmsd->name, ret);
>> +            goto val_error;
>> +        }
>> +        g_tree_insert(tree, key, val);
>> +    }
>> +    if (count != nnodes) {
>> +        error_report("%s inconsistent stream when loading the gtree",
>> +                     field->name);
>> +        return -EINVAL;
>> +    }
>> +    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
>> +    return ret;
>> +val_error:
>> +    g_free(val);
>> +key_error:
>> +    if (!direct_key) {
>> +        g_free(key);
>> +    }
>> +    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
>> +    return ret;
>> +}
>> +
>> +
>> +const VMStateInfo vmstate_info_gtree = {
>> +    .name = "gtree",
>> +    .get  = get_gtree,
>> +    .put  = put_gtree,
>> +};
>> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
>> index e80c4c6143..cc5fd8d3b1 100644
>> --- a/tests/test-vmstate.c
>> +++ b/tests/test-vmstate.c
>> @@ -812,6 +812,423 @@ static void test_load_q(void)
>>      qemu_fclose(fload);
>>  }
>>  
>> +/* interval (key) */
>> +typedef struct TestGTreeInterval {
>> +    uint64_t low;
>> +    uint64_t high;
>> +} TestGTreeInterval;
>> +
>> +#define VMSTATE_INTERVAL                               \
>> +{                                                      \
>> +    .name = "interval",                                \
>> +    .version_id = 1,                                   \
>> +    .minimum_version_id = 1,                           \
>> +    .fields = (VMStateField[]) {                       \
>> +        VMSTATE_UINT64(low, TestGTreeInterval),        \
>> +        VMSTATE_UINT64(high, TestGTreeInterval),       \
>> +        VMSTATE_END_OF_LIST()                          \
>> +    }                                                  \
>> +}
>> +
>> +/* mapping (value) */
>> +typedef struct TestGTreeMapping {
>> +    uint64_t phys_addr;
>> +    uint32_t flags;
>> +} TestGTreeMapping;
>> +
>> +#define VMSTATE_MAPPING                               \
>> +{                                                     \
>> +    .name = "mapping",                                \
>> +    .version_id = 1,                                  \
>> +    .minimum_version_id = 1,                          \
>> +    .fields = (VMStateField[]) {                      \
>> +        VMSTATE_UINT64(phys_addr, TestGTreeMapping),  \
>> +        VMSTATE_UINT32(flags, TestGTreeMapping),      \
>> +        VMSTATE_END_OF_LIST()                         \
>> +    },                                                \
>> +}
>> +
>> +static const VMStateDescription vmstate_interval_mapping[2] = {
>> +    VMSTATE_MAPPING,   /* value */
>> +    VMSTATE_INTERVAL   /* key   */
>> +};
>> +
>> +typedef struct TestGTreeDomain {
>> +    int32_t  id;
>> +    GTree    *mappings;
>> +} TestGTreeDomain;
>> +
>> +typedef struct TestGTreeIOMMU {
>> +    int32_t  id;
>> +    GTree    *domains;
>> +} TestGTreeIOMMU;
>> +
>> +/* Interval comparison function */
>> +static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>> +{
>> +    TestGTreeInterval *inta = (TestGTreeInterval *)a;
>> +    TestGTreeInterval *intb = (TestGTreeInterval *)b;
>> +
>> +    if (inta->high < intb->low) {
>> +        return -1;
>> +    } else if (intb->high < inta->low) {
>> +        return 1;
>> +    } else {
>> +        return 0;
>> +    }
>> +}
>> +
>> +/* ID comparison function */
>> +static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>> +{
>> +    uint ua = GPOINTER_TO_UINT(a);
>> +    uint ub = GPOINTER_TO_UINT(b);
>> +    return (ua > ub) - (ua < ub);
>> +}
>> +
>> +static void destroy_domain(gpointer data)
>> +{
>> +    TestGTreeDomain *domain = (TestGTreeDomain *)data;
>> +
>> +    g_tree_destroy(domain->mappings);
>> +    g_free(domain);
>> +}
>> +
>> +static int domain_preload(void *opaque)
>> +{
>> +    TestGTreeDomain *domain = opaque;
>> +
>> +    domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
>> +                                       NULL, g_free, g_free);
>> +    return 0;
>> +}
>> +
>> +static int iommu_preload(void *opaque)
>> +{
>> +    TestGTreeIOMMU *iommu = opaque;
>> +
>> +    iommu->domains = g_tree_new_full((GCompareDataFunc)int_cmp,
>> +                                     NULL, NULL, destroy_domain);
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_domain = {
>> +    .name = "domain",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .pre_load = domain_preload,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_INT32(id, TestGTreeDomain),
>> +        VMSTATE_GTREE_V(mappings, TestGTreeDomain, 1,
>> +                        vmstate_interval_mapping,
>> +                        TestGTreeInterval, TestGTreeMapping),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_iommu = {
>> +    .name = "iommu",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .pre_load = iommu_preload,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_INT32(id, TestGTreeIOMMU),
>> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, TestGTreeIOMMU, 1,
>> +                                   &vmstate_domain, TestGTreeDomain),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +uint8_t first_domain_dump[] = {
>> +    /* id */
>> +    0x00, 0x0, 0x0, 0x6,
>> +    0x00, 0x0, 0x0, 0x2, /* 2 mappings */
>> +    0x1, /* start of a */
>> +    /* a */
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xFF,
>> +    /* map_a */
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa0, 0x00,
>> +    0x00, 0x00, 0x00, 0x01,
>> +    0x1, /* start of b */
>> +    /* b */
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4F, 0xFF,
>> +    /* map_b */
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00,
>> +    0x00, 0x00, 0x00, 0x02,
>> +    0x0, /* end of gtree */
>> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
>> +};
>> +
>> +static TestGTreeDomain *create_first_domain(void)
>> +{
>> +    TestGTreeDomain *domain;
>> +    TestGTreeMapping *map_a, *map_b;
>> +    TestGTreeInterval *a, *b;
>> +
>> +    domain = g_malloc0(sizeof(TestGTreeDomain));
>> +    domain->id = 6;
>> +
>> +    a = g_malloc0(sizeof(TestGTreeInterval));
>> +    a->low = 0x1000;
>> +    a->high = 0x1FFF;
>> +
>> +    b = g_malloc0(sizeof(TestGTreeInterval));
>> +    b->low = 0x4000;
>> +    b->high = 0x4FFF;
>> +
>> +    map_a = g_malloc0(sizeof(TestGTreeMapping));
>> +    map_a->phys_addr = 0xa000;
>> +    map_a->flags = 1;
>> +
>> +    map_b = g_malloc0(sizeof(TestGTreeMapping));
>> +    map_b->phys_addr = 0xe0000;
>> +    map_b->flags = 2;
>> +
>> +    domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp, NULL,
>> +                                        (GDestroyNotify)g_free,
>> +                                        (GDestroyNotify)g_free);
>> +    g_tree_insert(domain->mappings, a, map_a);
>> +    g_tree_insert(domain->mappings, b, map_b);
>> +    return domain;
>> +}
>> +
>> +static void test_gtree_save_domain(void)
>> +{
>> +    TestGTreeDomain *first_domain = create_first_domain();
>> +
>> +    save_vmstate(&vmstate_domain, first_domain);
>> +    compare_vmstate(first_domain_dump, sizeof(first_domain_dump));
>> +    destroy_domain(first_domain);
>> +}
>> +
>> +struct match_node_data {
>> +    GTree *tree;
>> +    gpointer key;
>> +    gpointer value;
>> +};
>> +
>> +struct tree_cmp_data {
>> +    GTree *tree1;
>> +    GTree *tree2;
>> +    GTraverseFunc match_node;
>> +};
>> +
>> +static gboolean match_interval_mapping_node(gpointer key,
>> +                                            gpointer value, gpointer data)
>> +{
>> +    TestGTreeMapping *map_a, *map_b;
>> +    TestGTreeInterval *a, *b;
>> +    struct match_node_data *d = (struct match_node_data *)data;
>> +    char *str = g_strdup_printf("dest");
>> +
>> +    g_free(str);
>> +    a = (TestGTreeInterval *)key;
>> +    b = (TestGTreeInterval *)d->key;
>> +
>> +    map_a = (TestGTreeMapping *)value;
>> +    map_b = (TestGTreeMapping *)d->value;
>> +
>> +    assert(a->low == b->low);
>> +    assert(a->high == b->high);
>> +    assert(map_a->phys_addr == map_b->phys_addr);
>> +    assert(map_a->flags == map_b->flags);
>> +    g_tree_remove(d->tree, key);
>> +    return true;
>> +}
>> +
>> +static gboolean diff_tree(gpointer key, gpointer value, gpointer data)
>> +{
>> +    struct tree_cmp_data *tp = (struct tree_cmp_data *)data;
>> +    struct match_node_data d = {tp->tree2, key, value};
>> +
>> +    g_tree_foreach(tp->tree2, tp->match_node, &d);
>> +    g_tree_remove(tp->tree1, key);
>> +    return false;
>> +}
>> +
>> +static void compare_trees(GTree *tree1, GTree *tree2,
>> +                          GTraverseFunc function)
>> +{
>> +    struct tree_cmp_data tp = {tree1, tree2, function};
>> +
>> +    g_tree_foreach(tree1, diff_tree, &tp);
>> +    assert(g_tree_nnodes(tree1) == 0);
>> +    assert(g_tree_nnodes(tree2) == 0);
>> +}
>> +
>> +static void diff_domain(TestGTreeDomain *d1, TestGTreeDomain *d2)
>> +{
>> +    assert(d1->id == d2->id);
>> +    compare_trees(d1->mappings, d2->mappings, match_interval_mapping_node);
>> +}
>> +
>> +static gboolean match_domain_node(gpointer key, gpointer value, gpointer data)
>> +{
>> +    uint64_t id1, id2;
>> +    TestGTreeDomain *d1, *d2;
>> +    struct match_node_data *d = (struct match_node_data *)data;
>> +
>> +    id1 = (uint64_t)key;
>> +    id2 = (uint64_t)d->key;
>> +    d1 = (TestGTreeDomain *)value;
>> +    d2 = (TestGTreeDomain *)d->value;
>> +    assert(id1 == id2);
>> +    diff_domain(d1, d2);
>> +    g_tree_remove(d->tree, key);
>> +    return true;
>> +}
>> +
>> +static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
>> +{
>> +    assert(iommu1->id == iommu2->id);
>> +    compare_trees(iommu1->domains, iommu2->domains, match_domain_node);
>> +}
>> +
>> +static void test_gtree_load_domain(void)
>> +{
>> +    TestGTreeDomain *dest_domain = g_malloc0(sizeof(TestGTreeDomain));
>> +    TestGTreeDomain *orig_domain = create_first_domain();
>> +    QEMUFile *fload, *fsave;
>> +    char eof;
>> +
>> +    fsave = open_test_file(true);
>> +    qemu_put_buffer(fsave, first_domain_dump, sizeof(first_domain_dump));
>> +    g_assert(!qemu_file_get_error(fsave));
>> +    qemu_fclose(fsave);
>> +
>> +    fload = open_test_file(false);
>> +
>> +    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
>> +    eof = qemu_get_byte(fload);
>> +    g_assert(!qemu_file_get_error(fload));
>> +    g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
>> +    g_assert_cmpint(eof, ==, QEMU_VM_EOF);
>> +
>> +    diff_domain(orig_domain, dest_domain);
>> +    destroy_domain(orig_domain);
>> +    destroy_domain(dest_domain);
>> +    qemu_fclose(fload);
>> +}
>> +
>> +uint8_t iommu_dump[] = {
>> +    /* iommu id */
>> +    0x00, 0x0, 0x0, 0x7,
>> +    0x00, 0x0, 0x0, 0x2, /* 2 domains */
>> +    0x1,/* start of domain 5 */
>> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x0, 0x0, 0x5, /* key = 5 */
>> +        0x00, 0x0, 0x0, 0x5, /* domain1 id */
>> +        0x00, 0x0, 0x0, 0x1, /* 1 mapping */
>> +        0x1, /* start of mappings */
>> +            /* c */
>> +            0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
>> +            0x00, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0xFF,
>> +            /* map_c */
>> +            0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
>> +            0x00, 0x0, 0x0, 0x3,
>> +            0x0, /* end of domain1 mappings*/
>> +    0x1,/* start of domain 6 */
>> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x0, 0x0, 0x6, /* key = 6 */
>> +        0x00, 0x0, 0x0, 0x6, /* domain6 id */
>> +            0x00, 0x0, 0x0, 0x2, /* 2 mappings */
>> +            0x1, /* start of a */
>> +            /* a */
>> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
>> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xFF,
>> +            /* map_a */
>> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa0, 0x00,
>> +            0x00, 0x00, 0x00, 0x01,
>> +            0x1, /* start of b */
>> +            /* b */
>> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
>> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4F, 0xFF,
>> +            /* map_b */
>> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00,
>> +            0x00, 0x00, 0x00, 0x02,
>> +            0x0, /* end of domain6 mappings*/
>> +    0x0, /* end of domains */
>> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
>> +};
>> +
>> +static TestGTreeIOMMU *create_iommu(void)
>> +{
>> +    TestGTreeIOMMU *iommu = g_malloc0(sizeof(TestGTreeIOMMU));
>> +    TestGTreeDomain *first_domain = create_first_domain();
>> +    TestGTreeDomain *second_domain;
>> +    TestGTreeMapping *map_c;
>> +    TestGTreeInterval *c;
>> +
>> +    iommu->id = 7;
>> +    iommu->domains = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
>> +                                     NULL,
>> +                                     destroy_domain);
>> +
>> +    second_domain = g_malloc0(sizeof(TestGTreeDomain));
>> +    second_domain->id = 5;
>> +    second_domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
>> +                                              NULL,
>> +                                              (GDestroyNotify)g_free,
>> +                                              (GDestroyNotify)g_free);
>> +
>> +    g_tree_insert(iommu->domains, GUINT_TO_POINTER(6), first_domain);
>> +    g_tree_insert(iommu->domains, (gpointer)0x0000000000000005, second_domain);
>> +
>> +    c = g_malloc0(sizeof(TestGTreeInterval));
>> +    c->low = 0x1000000;
>> +    c->high = 0x1FFFFFF;
>> +
>> +    map_c = g_malloc0(sizeof(TestGTreeMapping));
>> +    map_c->phys_addr = 0xF000000;
>> +    map_c->flags = 0x3;
>> +
>> +    g_tree_insert(second_domain->mappings, c, map_c);
>> +    return iommu;
>> +}
>> +
>> +static void destroy_iommu(TestGTreeIOMMU *iommu)
>> +{
>> +    g_tree_destroy(iommu->domains);
>> +    g_free(iommu);
>> +}
>> +
>> +static void test_gtree_save_iommu(void)
>> +{
>> +    TestGTreeIOMMU *iommu = create_iommu();
>> +
>> +    save_vmstate(&vmstate_iommu, iommu);
>> +    compare_vmstate(iommu_dump, sizeof(iommu_dump));
>> +    destroy_iommu(iommu);
>> +}
>> +
>> +static void test_gtree_load_iommu(void)
>> +{
>> +    TestGTreeIOMMU *dest_iommu = g_malloc0(sizeof(TestGTreeIOMMU));
>> +    TestGTreeIOMMU *orig_iommu = create_iommu();
>> +    QEMUFile *fsave, *fload;
>> +    char eof;
>> +    int ret;
>> +
>> +    fsave = open_test_file(true);
>> +    qemu_put_buffer(fsave, iommu_dump, sizeof(iommu_dump));
>> +    g_assert(!qemu_file_get_error(fsave));
>> +    qemu_fclose(fsave);
>> +
>> +    fload = open_test_file(false);
>> +    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
>> +    ret = qemu_file_get_error(fload);
>> +    eof = qemu_get_byte(fload);
>> +    ret = qemu_file_get_error(fload);
>> +    g_assert(!ret);
>> +    g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
>> +    g_assert_cmpint(eof, ==, QEMU_VM_EOF);
>> +
>> +    diff_iommu(orig_iommu, dest_iommu);
>> +    destroy_iommu(orig_iommu);
>> +    destroy_iommu(dest_iommu);
>> +    qemu_fclose(fload);
>> +}
>> +
>>  typedef struct TmpTestStruct {
>>      TestStruct *parent;
>>      int64_t diff;
>> @@ -932,6 +1349,10 @@ int main(int argc, char **argv)
>>                      test_arr_ptr_prim_0_load);
>>      g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
>>      g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
>> +    g_test_add_func("/vmstate/gtree/save/savedomain", test_gtree_save_domain);
>> +    g_test_add_func("/vmstate/gtree/load/loaddomain", test_gtree_load_domain);
>> +    g_test_add_func("/vmstate/gtree/save/saveiommu", test_gtree_save_iommu);
>> +    g_test_add_func("/vmstate/gtree/load/loadiommu", test_gtree_load_iommu);
>>      g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
>>      g_test_run();
>>  
>> -- 
>> 2.20.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

