Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75351C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0A020716
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWkS2jkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0A020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9c2w-0007IQ-AF
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9c2F-0006sM-HF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9c2D-0007jO-8Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:58:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9c2D-0007iH-3U
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583359112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuBhMmTM55PQrCIQwFOWeU8+zxU7Uc+uLmVxrvfhwKk=;
 b=HWkS2jkvb60qXhAaPrg478Gf+ErvlLUHt71PfxhtXouPOz6qAKd4imeHU0+0FFv5JJvoPY
 O/yiRYJuAieMHgNAM7Jv8/YTladXcrRN04EPxR5jg3onmWeMLqlNBCHG3StV2MElPho+Sx
 87tKj3AmS/9W4JxtxuPLmglustjnSXw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-TlUDk2-XNGSBSs5k-0jUMg-1; Wed, 04 Mar 2020 16:58:30 -0500
X-MC-Unique: TlUDk2-XNGSBSs5k-0jUMg-1
Received: by mail-ed1-f70.google.com with SMTP id z20so2648230edr.11
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 13:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eQvyDdVALBRZmCZ1V0mJYztap26imWvTLEOZ4BjHmK4=;
 b=L1UXEIx0xIesR9jTuPDN5+YoNKagH/bPluhEtPk4LYB1j7e3S7nWzcBtXpweQg+Dlb
 v5vTTNVoY6xbP1yA6mROR8Z9v/7BC3ZHZZ/4kF5fEClqETD5YbieROOdTIrD+jeSfXWa
 GiC0lXS/vkkKUiH3H8MrXqNX8KKUJceFdIsk3aG0iOryjE5ddw9QnypJwNcQNE9PZ0eo
 +j556DTgfH9hzcDJnLmBPu5GldZgr5NMMRl8zm5xYAOXW4oD3TS1p7cQDqG1Lcgn6w5B
 z+2G+faC0qLpcO1VxpFyClm10A5AI1rfGWgnzogR4ns4CiaeAzkLcEbcFrQb83rFXMtQ
 uNFQ==
X-Gm-Message-State: ANhLgQ3rECJWZJIEq1ZVR1Y7F5znvB6QyJkXpMu0dCGT0eApOWA9iXTk
 IdAgqEKe0puegAOhGOmjBo6xE9E44/pJR0eK56FNm8xD9Ha1akk93GDKmhkasUaTlmwaHqiO36F
 DopqTvC98yo4MrPA=
X-Received: by 2002:a50:af81:: with SMTP id h1mr5010351edd.90.1583359109139;
 Wed, 04 Mar 2020 13:58:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu5x/ShRDXXU2cS/VC+2pX7FSJhG4beGQkrGyR0AK0chW5RldqrF2xKLZ3+ZouoGYSBpWrAng==
X-Received: by 2002:a50:af81:: with SMTP id h1mr5010324edd.90.1583359108828;
 Wed, 04 Mar 2020 13:58:28 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i9sm1693011edb.55.2020.03.04.13.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 13:58:28 -0800 (PST)
Subject: Re: [PATCH v7 06/10] iotests: limit line length to 79 chars
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200304213818.15341-1-jsnow@redhat.com>
 <20200304213818.15341-7-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a23da70f-a46f-acc8-18b4-c1b2e5cea60c@redhat.com>
Date: Wed, 4 Mar 2020 22:58:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304213818.15341-7-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 10:38 PM, John Snow wrote:
> 79 is the PEP8 recommendation. This recommendation works well for
> reading patch diffs in TUI email clients.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 69 ++++++++++++++++++++++-------------
>   tests/qemu-iotests/pylintrc   |  6 ++-
>   2 files changed, 48 insertions(+), 27 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 54d68774e1..1be11f491f 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -76,9 +76,11 @@
>   def qemu_img(*args):
>       '''Run qemu-img and return the exit code'''
>       devnull =3D open('/dev/null', 'r+')
> -    exitcode =3D subprocess.call(qemu_img_args + list(args), stdin=3Ddev=
null, stdout=3Ddevnull)
> +    exitcode =3D subprocess.call(qemu_img_args + list(args),
> +                               stdin=3Ddevnull, stdout=3Ddevnull)
>       if exitcode < 0:
> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
> +        sys.stderr.write('qemu-img received signal %i: %s\n' % (
> +            -exitcode, ' '.join(qemu_img_args + list(args))))

Do we want to indent Python like C and align argument below opening=20
parenthesis? Except when using sys.stderr.write() you seem to do it.

>       return exitcode
>  =20
>   def ordered_qmp(qmsg, conv_keys=3DTrue):
> @@ -117,7 +119,8 @@ def qemu_img_verbose(*args):
>       '''Run qemu-img without suppressing its output and return the exit =
code'''
>       exitcode =3D subprocess.call(qemu_img_args + list(args))
>       if exitcode < 0:
> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
> +        sys.stderr.write('qemu-img received signal %i: %s\n' % (
> +            -exitcode, ' '.join(qemu_img_args + list(args))))
>       return exitcode
>  =20
>   def qemu_img_pipe(*args):
> @@ -128,7 +131,8 @@ def qemu_img_pipe(*args):
>                               universal_newlines=3DTrue)
>       exitcode =3D subp.wait()
>       if exitcode < 0:
> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
> +        sys.stderr.write('qemu-img received signal %i: %s\n' % (
> +            -exitcode, ' '.join(qemu_img_args + list(args))))
>       return subp.communicate()[0]
>  =20
>   def qemu_img_log(*args):
> @@ -158,7 +162,8 @@ def qemu_io(*args):
>                               universal_newlines=3DTrue)
>       exitcode =3D subp.wait()
>       if exitcode < 0:
> -        sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode=
, ' '.join(args)))
> +        sys.stderr.write('qemu-io received signal %i: %s\n' % (
> +            -exitcode, ' '.join(args)))
>       return subp.communicate()[0]
>  =20
>   def qemu_io_log(*args):
> @@ -280,10 +285,13 @@ def filter_test_dir(msg):
>   def filter_win32(msg):
>       return win32_re.sub("", msg)
>  =20
> -qemu_io_re =3D re.compile(r"[0-9]* ops; [0-9\/:. sec]* \([0-9\/.inf]* [E=
PTGMKiBbytes]*\/sec and [0-9\/.inf]* ops\/sec\)")
> +qemu_io_re =3D re.compile(r"[0-9]* ops; [0-9\/:. sec]* "
> +                        r"\([0-9\/.inf]* [EPTGMKiBbytes]*\/sec "
> +                        r"and [0-9\/.inf]* ops\/sec\)")
>   def filter_qemu_io(msg):
>       msg =3D filter_win32(msg)
> -    return qemu_io_re.sub("X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/se=
c)", msg)
> +    return qemu_io_re.sub("X ops; XX:XX:XX.X "
> +                          "(XXX YYY/sec and XXX ops/sec)", msg)
>  =20
>   chown_re =3D re.compile(r"chown [0-9]+:[0-9]+")
>   def filter_chown(msg):
> @@ -335,7 +343,9 @@ def filter_img_info(output, filename):
>           line =3D line.replace(filename, 'TEST_IMG') \
>                      .replace(imgfmt, 'IMGFMT')
>           line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
> -        line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XX=
XX-XXXXXXXXXXXX', line)
> +        line =3D re.sub('uuid: [-a-f0-9]+',
> +                      'uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
> +                      line)
>           line =3D re.sub('cid: [0-9]+', 'cid: XXXXXXXXXX', line)
>           lines.append(line)
>       return '\n'.join(lines)
> @@ -356,12 +366,9 @@ def log(msg, filters=3D(), indent=3DNone):
>       for flt in filters:
>           msg =3D flt(msg)
>       if isinstance(msg, (dict, list)):
> -        # Python < 3.4 needs to know not to add whitespace when pretty-p=
rinting:
> -        separators =3D (', ', ': ') if indent is None else (',', ': ')
>           # Don't sort if it's already sorted
>           do_sort =3D not isinstance(msg, OrderedDict)
> -        print(json.dumps(msg, sort_keys=3Ddo_sort,
> -                         indent=3Dindent, separators=3Dseparators))
> +        print(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dindent))

Unrelated change. Maybe worth a separate patch?

>       else:
>           print(msg)
>  =20
> @@ -529,11 +536,13 @@ def pause_drive(self, drive, event=3DNone):
>               self.pause_drive(drive, "write_aio")
>               return
>           self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, =
event, drive))
> +                 command_line=3D'qemu-io %s "break %s bp_%s"' % (
> +                     drive, event, drive))
>  =20
>       def resume_drive(self, drive):
>           self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (dri=
ve, drive))
> +                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (
> +                     drive, drive))

Can this work?

                     command_line=3D'qemu-io %s "remove_break bp_%s"'
                                  % (drive, drive))

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>       def hmp_qemu_io(self, drive, cmd):
>           '''Write to a given drive using an HMP command'''
> @@ -790,16 +799,18 @@ def dictpath(self, d, path):
>                   idx =3D int(idx)
>  =20
>               if not isinstance(d, dict) or component not in d:
> -                self.fail('failed path traversal for "%s" in "%s"' % (pa=
th, str(d)))
> +                self.fail(f'failed path traversal for "{path}" in "{d}"'=
)
>               d =3D d[component]
>  =20
>               if m:
>                   if not isinstance(d, list):
> -                    self.fail('path component "%s" in "%s" is not a list=
 in "%s"' % (component, path, str(d)))
> +                    self.fail(f'path component "{component}" in "{path}"=
 '
> +                              f'is not a list in "{d}"')
>                   try:
>                       d =3D d[idx]
>                   except IndexError:
> -                    self.fail('invalid index "%s" in path "%s" in "%s"' =
% (idx, path, str(d)))
> +                    self.fail(f'invalid index "{idx}" in path "{path}" '
> +                              f'in "{d}"')
>           return d
>  =20
>       def assert_qmp_absent(self, d, path):
> @@ -850,10 +861,13 @@ def assert_json_filename_equal(self, json_filename,=
 reference):
>           '''Asserts that the given filename is a json: filename and that=
 its
>              content is equal to the given reference object'''
>           self.assertEqual(json_filename[:5], 'json:')
> -        self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_file=
name[5:])),
> -                         self.vm.flatten_qmp_object(reference))
> +        self.assertEqual(
> +            self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
> +            self.vm.flatten_qmp_object(reference)
> +        )
>  =20
> -    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3D=
False, wait=3D60.0):
> +    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse,
> +                        resume=3DFalse, wait=3D60.0):
>           '''Cancel a block job and wait for it to finish, returning the =
event'''
>           result =3D self.vm.qmp('block-job-cancel', device=3Ddrive, forc=
e=3Dforce)
>           self.assert_qmp(result, 'return', {})
> @@ -877,8 +891,8 @@ def cancel_and_wait(self, drive=3D'drive0', force=3DF=
alse, resume=3DFalse, wait=3D60.0):
>           self.assert_no_active_block_jobs()
>           return result
>  =20
> -    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
, wait=3D60.0,
> -                             error=3DNone):
> +    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
,
> +                             wait=3D60.0, error=3DNone):
>           '''Wait for a block job to finish, returning the event'''
>           while True:
>               for event in self.vm.get_qmp_events(wait=3Dwait):
> @@ -1017,8 +1031,11 @@ def verify_quorum():
>           notrun('quorum support missing')
>  =20
>   def qemu_pipe(*args):
> -    '''Run qemu with an option to print something and exit (e.g. a help =
option),
> -    and return its output'''
> +    """
> +    Run qemu with an option to print something and exit (e.g. a help opt=
ion).
> +
> +    :return: QEMU's stdout output.
> +    """
>       args =3D [qemu_prog] + qemu_opts + list(args)
>       subp =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE,
>                               stderr=3Dsubprocess.STDOUT,
> @@ -1056,8 +1073,8 @@ def func_wrapper(test_case: QMPTestCase, *args, **k=
wargs):
>  =20
>               usf_list =3D list(set(fmts) - set(supported_formats(read_on=
ly)))
>               if usf_list:
> -                test_case.case_skip('{}: formats {} are not whitelisted'=
.format(
> -                    test_case, usf_list))
> +                test_case.case_skip(f'{test_case}: formats {usf_list} '
> +                                    'are not whitelisted')
>                   return None
>               else:
>                   return func(test_case, *args, **kwargs)
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> index 8720b6a0de..8d02f00607 100644
> --- a/tests/qemu-iotests/pylintrc
> +++ b/tests/qemu-iotests/pylintrc
> @@ -19,4 +19,8 @@ disable=3Dinvalid-name,
>           too-many-public-methods,
>           # These are temporary, and should be removed:
>           missing-docstring,
> -        line-too-long,
> +
> +[FORMAT]
> +
> +# Maximum number of characters on a single line.
> +max-line-length=3D79
>=20


