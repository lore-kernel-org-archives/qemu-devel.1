Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69341C47254
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2507120873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eC0YcXz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2507120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDV8-0006sx-8l
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jUDSz-0004eQ-B6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jUDQC-0005lX-5Y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:59:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jUDQB-0005lH-JP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 13:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588269386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DP42sZ/ZiSSl/FOoCFlcnUX5Y1oeC4eEQ9+nBCjLg2A=;
 b=eC0YcXz8m9ngViP4KFvu5/nLlw9InXB5Kpb6uwdnZggozrAjbT10hnC/3gkbtKI9RuAF1S
 CSv7Q7OwnJ/eMWNOSlD+/35UxmrOhYRDgZuZ8ioe5KQr7/6EMCXZjY+C0FEperKuiTfsg+
 5Sw548kkEFlumAVInyPRxFVOT109W+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-ZmcaeL3fPZOK1B8wYvirTw-1; Thu, 30 Apr 2020 13:56:22 -0400
X-MC-Unique: ZmcaeL3fPZOK1B8wYvirTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500951895870;
 Thu, 30 Apr 2020 17:56:21 +0000 (UTC)
Received: from [10.10.117.103] (ovpn-117-103.rdu2.redhat.com [10.10.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D0395D9F1;
 Thu, 30 Apr 2020 17:56:16 +0000 (UTC)
Subject: Re: [PATCH 4/4] scripts/qmp: Fix QEMU Python scripts path
To: Markus Armbruster <armbru@redhat.com>
References: <20200421094216.24927-1-f4bug@amsat.org>
 <20200421094216.24927-5-f4bug@amsat.org>
 <395d7263-c4f0-7422-0355-7e082135f6cd@redhat.com>
 <878sidimxu.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <21ffc136-7905-e0aa-bad2-8d980fd15349@redhat.com>
Date: Thu, 30 Apr 2020 13:56:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <878sidimxu.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/30/20 1:04 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
>=20
>> On 4/21/20 5:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> QEMU Python scripts have been moved in commit 8f8fd9edba4 ("Introduce
>>> Python module structure"). Use the same sys.path modification used
>>> in the referenced commit to be able to use these scripts again.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  scripts/qmp/qmp      | 4 +++-
>>>  scripts/qmp/qom-fuse | 4 +++-
>>>  scripts/qmp/qom-get  | 4 +++-
>>>  scripts/qmp/qom-list | 4 +++-
>>>  scripts/qmp/qom-set  | 4 +++-
>>>  scripts/qmp/qom-tree | 4 +++-
>>>  6 files changed, 18 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
>>> index 0625fc2aba..8e52e4a54d 100755
>>> --- a/scripts/qmp/qmp
>>> +++ b/scripts/qmp/qmp
>>> @@ -11,7 +11,9 @@
>>>  # See the COPYING file in the top-level directory.
>>> =20
>>>  import sys, os
>>> -from qmp import QEMUMonitorProtocol
>>> +
>>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'p=
ython'))
>>> +from qemu.qmp import QEMUMonitorProtocol
>>> =20
>>
>> Try to avoid using sys.path hacks; they don't work in pylint or mypy and
>> it provides an active barrier to CQA work here.
>> (They also tend to be quite fragile.)
>>
>> We can discuss the right way to do this; one of those ways is to create
>> an installable package that we can install locally in a virtual environm=
ent.
>>
>> Another way is perhaps to set PYTHONPATH in the calling environment so
>> that standard "import" directives will work.
>>
>> Both ultimately involve changing the environment of the user to
>> accommodate the script.
>=20
> For what it's worth, tests/Makefile.involve does the latter for
> tests/qapi-schema/test-qapi.py.  Simple enough, but makes manual
> invocation inconvenient.
>=20
> Not necessary for scripts/qapi-gen.py, because its "import qmp.FOO"
> finds qmp right in scripts/qmp/.
>=20

Yes, using "proper" package hierarchies often means the loss of being
able to invoke the scripts directly, unless you are careful to organize
the package such that the scripts can run both in an "unpackaged" and a
"packaged" mode.

It can be done, but it's tricky and can be prone to error. Let's take a
look at how to do it!

Let's imagine we have an honest-to-goodness QAPI parser module. In
isolation, the layout for such a package would probably look like this:

qapi.git/
  setup.py
  qapi-gen.py
  README.rst
  qapi/
    __init__.py
    parser.py
    schema.py
    ...etc


Now, anything inside of qapi/ is considered the "qapi module" and you
will be unable to directly execute anything inside of this folder,
unless it does not depend on anything else in the "qapi module".

i.e. "import qapi.x" will work, but only from the executing context of a
thread that understands how to find "qapi". If you are IN this
directory, you do not have that context, so those directives will not work.

Python imports are always handled relative to the importing file, not
the imported file.

qapi-gen in the parent directory, however, can use "from qapi import
parser" without any problem, because if you are executing it directly,
it will be able to see the "qapi module" as a folder.

When packaging this for installed environments, there are some changes
we need to make.

(1) Move qapi-gen.py into the module itself! Remove the shebang, the
chmod, and any __main__ scaffolding. Name it something like "script.py".
It should look like this:

```
from qapi import parser, schema

def main():
    print("running qapi-gen!")
```

(2) Create a new shim executable where qapi-gen.py used to be. Give it
chmod u+x and name it qapi-gen.py, and it should look like this:

```
#!/usr/bin/env python3

from qapi import script

if __name__ =3D=3D '__main__':
    script.main()
```

Now, at this point, you should be able to execute "qapi-gen.py" no
matter what your CWD is, as long as the qapi-gen.py shim is in your PATH.

To finish packaging this for installation purposes, though, we'll amend
setup.py to contain something like this:

setup_kwargs =3D {
    'entry_points': {
        'console_scripts': [
            'qapi-gen =3D qapi.script:main',
        ],
    },
}

Next, when you *install* this package, let's say by doing this:

> cd ~/src/qapi.git/

# Make a new virtual environment and enter it as a shell
> pipenv shell

# (If you skip the above step or don't want a venv, do this:)
# pip install --user -e .

# If you are inside the venv, do this:
pip install -e .

(This will install the python package in an "editable" or "develop"
mode, which creates a fake package header that simply redirects to the
real, live files. This means as you edit the files, the python package
is updated in real time. It's a lifesaver trick if you don't know about
it already.)


From here, the "qapi" package is "installed" to your environment. You
should be able to pop open a python3 terminal anywhere and "import qapi"
and have that work.

You should also now have the "qapi-gen" executable in your path (or in
~/.local/bin/ if you are not in a venv) that will invoke the entrypoint
directly.

At this point, both the shim executable and the "installed version" of
the script should work correctly; offering a dual-paradigm package where
you can run and edit it in-tree, or in an installed environment.

It takes a bit more elbow grease, but tools like mypy, pylint and flake8
will better be able to understand and follow the code. You will also not
lose the ability to run scripts quickly in the source tree, but I must
caution that I don't believe this to be a viable strategy long term.

As soon as we have two or more packages that each need "common imports",
it's no longer possible to structure all dependencies as subfolders of
the common scripts, and we lose the ability to perform this "trick".

The only way to accomplish that complex structure is by installing the
packages to the venv; or using PYTHONPATH to amend the search path
outside of the script directly.

--js


P.S.: Of course, I could be wrong. Python packaging changes a lot and
there are a lot of caveats and weird hacks and ways to do almost
anything you want, but it's a matter of what will work well Out Of The
Box with common tooling. For that purpose, I generally want things to
work with pycharm, flake8, mypy, and pylint.


