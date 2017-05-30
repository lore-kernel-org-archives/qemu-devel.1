Received: from eggs.gnu.org ([2001:4830:134:3::10]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFbqZ-0001Vi-QJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 03:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFbqY-0005vI-Sh
	for qemu-devel@nongnu.org; Tue, 30 May 2017 03:45:43 -0400
References: <1494585229-9119-1-git-send-email-thuth@redhat.com>
	<87k24yudi5.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6857cff-4109-3e1c-c20b-0220edcb5b8a@redhat.com>
Date: Tue, 30 May 2017 09:45:33 +0200
MIME-Version: 1.0
In-Reply-To: <87k24yudi5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: Print a warning for legacy
 drive options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 30.05.2017 07:20, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> We likely do not want to carry these legacy -drive options along forever.
>> Let's emit a deprecation warning for the -drive options that have a
>> replacement with the -device option, so that the (hopefully few) remaining
>> users are aware of this and can adapt their scripts / behaviour accordingly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>>      /* Change legacy command line options into QMP ones */
>>      static const struct {
>> @@ -880,6 +884,16 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>        if (qemu_opt_get(legacy_opts, "boot") != NULL) {
>            fprintf(stderr, "qemu-kvm: boot=on|off is deprecated and will be "
>                    "ignored. Future versions will reject this parameter. Please "
>>                  "update your scripts.\n");
> 
> Unrelated to this patch: this is ugly.  It's also almost three years
> old.  Can we bury the corpse already?

If you like to get rid of this now, feel free to send a patch ...
otherwise I'll make sure that it'll go away with QEMU v3.0 (it's on the
to-be-removed list on http://wiki.qemu.org/Features/LegacyRemoval already)

[...]
>> @@ -631,7 +633,8 @@ an untrusted format header.
>>  @item serial=@var{serial}
>>  This option specifies the serial number to assign to the device.
>>  @item addr=@var{addr}
>> -Specify the controller's PCI address (if=virtio only).
>> +Specify the controller's PCI address (if=virtio only). This parameter is
>> +deprecated, use the corresponding parameter of @code{-device} instead.
>>  @item werror=@var{action},rerror=@var{action}
>>  Specify which @var{action} to take on write and read errors. Valid actions are:
>>  "ignore" (ignore the error and try to continue), "stop" (pause QEMU),
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

 Thanks!
  Thomas
