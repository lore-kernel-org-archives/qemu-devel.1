Received: from eggs.gnu.org ([2001:4830:134:3::10]:52510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ce6Hh-00021u-CJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1ce6Hf-0002Su-GM
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:34:41 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1ce6Hf-0002SI-9s
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:34:39 -0500
Received: by mail-it0-x243.google.com with SMTP id 203so182948ith.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 12:34:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170215035457.GA19045@localhost.localdomain>
References: <1486617814-5420-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170209062928.GI27752@localhost.localdomain>
	<CAAo6VWNGtLvbN4ktxRQ9SsobNCgJWcaa_zvdA-9q2Pp3YK27gg@mail.gmail.com>
	<20170214205158.GT27752@localhost.localdomain>
	<CAAo6VWO64cuJZaNDSzFM6d2YFXr41nc78cPKBR=mbJc5mRD=0w@mail.gmail.com>
	<CAAo6VWPUL7=jotUzgbA7ko-9+WjeqL7kxWF_1LVLQxs8Y6ajbg@mail.gmail.com>
	<20170215035457.GA19045@localhost.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 15 Feb 2017 12:34:35 -0800
Message-ID: <CAAo6VWOvu34iAucwbY+THTq1fShn_HahMxmK2tiriCBm68Xh6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

Thanks! Will change accordingly in the next patch.

On Tue, Feb 14, 2017 at 7:54 PM, Jeff Cody <jcody@redhat.com> wrote:
> On Tue, Feb 14, 2017 at 07:02:32PM -0800, ashish mittal wrote:
>> On Tue, Feb 14, 2017 at 2:34 PM, ashish mittal <ashmit602@gmail.com> wrote:
>> > On Tue, Feb 14, 2017 at 12:51 PM, Jeff Cody <jcody@redhat.com> wrote:
>> >> On Thu, Feb 09, 2017 at 01:24:58AM -0800, ashish mittal wrote:
>> >>> On Wed, Feb 8, 2017 at 10:29 PM, Jeff Cody <jcody@redhat.com> wrote:
>> >>> > On Wed, Feb 08, 2017 at 09:23:33PM -0800, Ashish Mittal wrote:
>> >>> >> From: Ashish Mittal <ashish.mittal@veritas.com>
>> >>> >>
>> >>> >> Source code for the qnio library that this code loads can be downloaded from:
>> >>> >> https://github.com/VeritasHyperScale/libqnio.git
>> >>> >>
>> >>> >> Sample command line using JSON syntax:
>> >>> >> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
>> >>> >> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
>> >>> >> -msg timestamp=on
>> >>> >> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
>> >>> >> "server":{"host":"172.172.17.4","port":"9999"}}'
>> >>> >>
>> >>> >> Sample command line using URI syntax:
>> >>> >> qemu-img convert -f raw -O raw -n
>> >>> >> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
>> >>> >> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
>> >>> >>
>> >>
>> >> [...]
>> >>
>> >>> >> +#define VXHS_OPT_FILENAME           "filename"
>> >>> >> +#define VXHS_OPT_VDISK_ID           "vdisk-id"
>> >>> >> +#define VXHS_OPT_SERVER             "server"
>> >>> >> +#define VXHS_OPT_HOST               "host"
>> >>> >> +#define VXHS_OPT_PORT               "port"
>> >>> >> +#define VXHS_UUID_DEF "12345678-1234-1234-1234-123456789012"
>> >>> >
>> >>> > What is this?  It is not a valid UUID; is the value significant?
>> >>> >
>> >>>
>> >>> This value gets passed to libvxhs for binaries like qemu-io, qemu-img
>> >>> that do not have an Instance ID. We can use this default ID to control
>> >>> access to specific vdisks by these binaries. qemu-kvm will pass the
>> >>> actual instance ID, and therefore will not use this default value.
>> >>>
>> >>> Will reply to other queries soon.
>> >>>
>> >>
>> >> If you are going to call it a UUID, it should adhere to the RFC 4122 spec.
>> >> You can easily generate a compliant UUID with uuidgen.  However:
>> >>
>> >> Can you explain more about how you are using this to control access by
>> >> qemu-img and qemu-io?  Looking at libqnio, it looks like this is used to
>> >> determine at runtime which TLS certs to use based off of a
>> >> pathname/filename, which is then how I presume you are controlling access.
>> >> See Daniel's email regarding TLS certificates.
>> >>
>> >
>> > (1) The default behavior would be to disallow access to any vdisks by
>> > the non qemu-kvm binaries. qemu-kvm would use the actual instance ID
>> > for authentication.
>> > (2) Depending on the workflow, HyperScale controller can choose to
>> > grant *temporary* access to specific vdisks by qemu-img, qemu-io
>> > binaries (identified by the default VXHS_UUID_DEF above).
>> > (3) This information, described in #2, would be communicated by the
>> > HyperScale controller to the actual proprietary VxHS server (running
>> > on each compute) that does the authentication/SSL.
>> > (4) The HyperScale controller, in this way, can grant/revoke access
>> > for specific vdisks not just to clients with VXHS_UUID_DEF instance
>> > ID, but also the actual VM instances.
>> >
>> >> [...]
>> >>
>> >>> >> +
>> >>> >> +static void bdrv_vxhs_init(void)
>> >>> >> +{
>> >>> >> +    char out[37];
>> >>
>> >> Additional point: this should be sized as UUID_FMT_LEN + 1, not 37, but I
>> >> suspect this code is changing anyways.
>> >>
>> >>> >> +
>> >>> >> +    if (qemu_uuid_is_null(&qemu_uuid)) {
>> >>> >> +        lib_init_failed = iio_init(QNIO_VERSION, vxhs_iio_callback, VXHS_UUID_DEF);
>> >>> >> +    } else {
>> >>> >> +        qemu_uuid_unparse(&qemu_uuid, out);
>> >>> >> +        lib_init_failed = iio_init(QNIO_VERSION, vxhs_iio_callback, out);
>> >>> >> +    }
>> >>> >> +
>> >>> >
>> >>> > [1]
>> >>> >
>> >>> > Can you explain what is going on here with the qemu_uuid check?
>> >>> >
>> >
>> > (1) qemu_uuid_is_null(&qemu_uuid) is true for qemu-io, qemu-img that
>> > do not define a instance ID. We end up using the default VXHS_UUID_DEF
>> > ID for them, and authenticating them as described above.
>> >
>> > (2) For the other case 'else', we convert the uuid to a char * using
>> > qemu_uuid_unparse(), and pass the resulting char * uuid in variable
>> > 'out' to libvxhs.
>> >
>> >>> >
>> >>> > You also can't do this here.  This init function is just to register the
>> >>> > driver (e.g. populate the BlockDriver list).  You shouldn't be doing
>> >>> > anything other than the bdrv_register() call here.
>> >>> >
>> >>> > Since you want to run this iio_init only once, I would recommend doing it in
>> >>> > the vxhs_open() call, and using a ref counter.  That way, you can also call
>> >>> > iio_fini() to finish releasing resources once the last device is closed.
>> >>> >
>> >>> > This was actually a suggestion I had before, which you then incorporated
>> >>> > into v6, but it appears all the refcnt code has gone away for v7/v8.
>> >>> >
>> >>> >
>> >>> >> +    bdrv_register(&bdrv_vxhs);
>> >>> >> +}
>> >>> >> +
>> >
>>
>> Per my understanding, device open and close are serialized, therefore
>> I would not need to use the refcnt under a lock.
>
> Correct.
>
>> Does the following diff look ok for the refcnt and iio_fini() change?
>>
>
> Disclaimer, the following was compiled in my mind only.
>
> Create a wrapper for the ref, and initialize automatically when appropriate.
> For instance:
>
>
>
> /* Only refs after successful init */
> int vxhs_init_and_ref() {
>     if (vxhs_ref == 0) {
>         char out[UUID_FMT_LEN + 1];
>         if (qemu_uuid_is_null(&qemu_uuid)) {
>             if (iio_init(QNIO_VERSION, vxhs_iio_callback, VXHS_UUID_DEF))
>                 return -ENODEV;
>         } else {
>             qemu_uuid_unparse(&qemu_uuid, out);
>             if (iio_init(QNIO_VERSION, vxhs_iio_callback, out))
>                 return -ENODEV;
>         }
>     }
>     vxhs_ref++;
>     return 0;
> }
>
>
> And then another wrapper to unref it, and then call iio_fini() as
> appropriate:
>
>
> void vxhs_unref() {
>     if (vxhs_ref && --vxhs_ref == 0) {
>         iio_fini();
>     }
> }
>
> Now whenever you ref or unref the usage counter, everything happens
> correctly automatically.
>
> Then the rest of the patch becomes:
>
>> diff --git a/block/vxhs.c b/block/vxhs.c
>> index f1b5f1c..d07a461 100644
>> --- a/block/vxhs.c
>> +++ b/block/vxhs.c
>> @@ -27,7 +27,7 @@
>>
>>  QemuUUID qemu_uuid __attribute__ ((weak));
>>
>> -static int lib_init_failed;
>> +static uint32_t refcnt;
>
> Minor nit: I'd call it vxhs_ref (just a preference).
>
>>
>>  typedef enum {
>>      VDISK_AIO_READ,
>> @@ -232,9 +232,24 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
>>      char *str = NULL;
>>      int ret = 0;
>>
>> -    if (lib_init_failed) {
>> -        return -ENODEV;
>
>
>> +    if (refcnt == 0) {
>> +        char out[UUID_FMT_LEN + 1];
>> +        if (qemu_uuid_is_null(&qemu_uuid)) {
>> +            if (iio_init(QNIO_VERSION, vxhs_iio_callback, VXHS_UUID_DEF))
>> +                return -ENODEV;
>> +        } else {
>> +            qemu_uuid_unparse(&qemu_uuid, out);
>> +            if (iio_init(QNIO_VERSION, vxhs_iio_callback, out))
>> +                return -ENODEV;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * Increment refcnt before actual open.
>> +     * We will decrement it if there is an error.
>> +     */
>> +    refcnt++;
>> +
>
> This block then just becomes:
>
>       ret = vxhs_init_and_ref();
>       if (ret < 0) {
>           return ret;
>       }
>
>
>>      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>>      qemu_opts_absorb_qdict(opts, options, &local_err);
>>      if (local_err) {
>> @@ -323,6 +338,13 @@ out:
>>      qemu_opts_del(opts);
>>
>>      if (ret < 0) {
>> +        if (refcnt == 1) {
>> +            /*
>> +             * First device open resulted in error.
>> +             */
>> +            iio_fini();
>> +        }
>> +        refcnt--;
>
> This hunk can just be replaced with:
>
>     vxhs_unref();
>
>>          error_propagate(errp, local_err);
>>          g_free(s->vdisk_hostinfo.host);
>>          g_free(s->vdisk_guid);
>> @@ -428,6 +450,10 @@ static void vxhs_close(BlockDriverState *bs)
>>          s->vdisk_hostinfo.dev_handle = NULL;
>>      }
>>
>> +    if (--refcnt == 0) {
>> +        iio_fini();
>> +    }
>> +
>
> Same here:
>
>     vxhs_unref();
>
>
>>      /*
>>       * Free the dynamically allocated host string
>>       */
>> @@ -484,15 +510,6 @@ static BlockDriver bdrv_vxhs = {
>>
>>  static void bdrv_vxhs_init(void)
>>  {
>> -    char out[37];
>> -
>> -    if (qemu_uuid_is_null(&qemu_uuid)) {
>> -        lib_init_failed = iio_init(QNIO_VERSION, vxhs_iio_callback,
>> VXHS_UUID_DEF);
>> -    } else {
>> -        qemu_uuid_unparse(&qemu_uuid, out);
>> -        lib_init_failed = iio_init(QNIO_VERSION, vxhs_iio_callback, out);
>> -    }
>> -
>>      bdrv_register(&bdrv_vxhs);
>>  }
>>
>> Thanks,
>> Ashish
>>
>
> -Jeff
