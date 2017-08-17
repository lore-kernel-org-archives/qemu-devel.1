Received: from eggs.gnu.org ([2001:4830:134:3::10]:40708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diPL8-0004ji-IC
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diPL4-0003tt-8M
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:16:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1diPL3-0003oP-Tn
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:16:14 -0400
References: <20170815085732.9794-1-ldoktor@redhat.com>
	<20170815085732.9794-2-ldoktor@redhat.com>
	<87fuctm2ql.fsf@dusky.pond.sub.org>
	<343636b3-85d2-cb2b-8975-dcc1bb0ddee1@redhat.com>
	<87pobvxxdb.fsf@dusky.pond.sub.org>
	<6363601c-231e-7910-3e76-9497a4645e81@redhat.com>
	<87efsasr62.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <a47ce7e9-ec6c-0030-9123-cac5cec667b4@redhat.com>
Date: Thu, 17 Aug 2017 20:16:01 +0200
MIME-Version: 1.0
In-Reply-To: <87efsasr62.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="raJ2osMbRbl9DubdJHlhmMeP9OHohnvjj"
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--raJ2osMbRbl9DubdJHlhmMeP9OHohnvjj
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org
Message-ID: <a47ce7e9-ec6c-0030-9123-cac5cec667b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/10] qemu.py: Pylint/style fixes
References: <20170815085732.9794-1-ldoktor@redhat.com>
 <20170815085732.9794-2-ldoktor@redhat.com>
 <87fuctm2ql.fsf@dusky.pond.sub.org>
 <343636b3-85d2-cb2b-8975-dcc1bb0ddee1@redhat.com>
 <87pobvxxdb.fsf@dusky.pond.sub.org>
 <6363601c-231e-7910-3e76-9497a4645e81@redhat.com>
 <87efsasr62.fsf@dusky.pond.sub.org>
In-Reply-To: <87efsasr62.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 17.8.2017 v 07:24 Markus Armbruster napsal(a):
> Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:
>=20
>> Dne 16.8.2017 v 18:58 Markus Armbruster napsal(a):
>>> Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:
>>>
>>>> Dne 15.8.2017 v 14:31 Markus Armbruster napsal(a):
>>>>> Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> writes:
>>>>>
>>>>>> No actual code changes, just several pylint/style fixes and docstr=
ing
>>>>>> clarifications.
>>>>>>
>>>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>>>> ---
>>>>>>  scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++----=
-------------
>>>>>>  1 file changed, 53 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>>>> index 880e3e8..466aaab 100644
>>>>>> --- a/scripts/qemu.py
>>>>>> +++ b/scripts/qemu.py
>>>>>> @@ -23,8 +23,22 @@ import qmp.qmp
>>>>>>  class QEMUMachine(object):
>>>>>>      '''A QEMU VM'''
>>>>>> =20
>>>>>> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNo=
ne, test_dir=3D"/var/tmp",
>>>>>> -                 monitor_address=3DNone, socket_scm_helper=3DNone=
, debug=3DFalse):
>>>>>> +    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNo=
ne,
>>>>>> +                 test_dir=3D"/var/tmp", monitor_address=3DNone,
>>>>>> +                 socket_scm_helper=3DNone, debug=3DFalse):
>>>>>> +        '''
>>>>>> +        Create a QEMUMachine object
>>>>>
>>>>> Initialize a QEMUMachine
>>>>>
>>>>> Rationale: it's __init__, not __create__, and "object" is redundant=
=2E
>>>>>
>>>>
>>>> sure
>>>>
>>>>>> +
>>>>>> +        @param binary: path to the qemu binary (str)
>>>>>
>>>>> Drop (str), because what else could it be?
>>>>
>>>> it could be shlex.split of arguments to be passed to process. Anyway=
 no strong opinion here so I dropping it...
>>>>
>>>>>
>>>>>> +        @param args: initial list of extra arguments
>>>>>
>>>>> If this is the initial list, then what's the final list?
>>>>>
>>>>
>>>> It's the basic set of arguments which can be modified before the exe=
cution. Do you think it requires additional explanation, or would you lik=
e to improve it somehow?
>>>
>>> Can this list of extra arguments really be *modified*?  Adding more
>>> arguments doesn't count for me --- I'd consider them added to the
>>> "non-extra" arguments.
>>>
>>
>> Yes, one can remove, shuffle or modify it.
>=20
> Bizarre :)
>=20
> Who's "one"?
>=20

The user, or some inherited classes (eg. iotest.py). Currently nobody doe=
s that, but one might...

>>> Drop "initial"?
>>
>> I can do that but it can give false impression that the args will be p=
resent. Anyway it's probably just a corner case so I'll drop it.
>=20
> If it's intended to be modified, then keeping "initial" might be best.
> Your choice.
>=20

OK, let's not over-complicate it and just say it's list of extra argument=
s.

>>>
>>>>>> +        @param wrapper: list of arguments used as prefix to qemu =
binary
>>>>>> +        @param name: name of this object (used for log/monitor/..=
=2E file names)
>>>>> prefix for socket and log file names (default: qemu-PID)
>>>>>
>>>>
>>>> Sure, both make sense to me.
>>>>
>>>>>> +        @param test_dir: base location to put log/monitor/... fil=
es in
>>>>>
>>>>> where to create socket and log file
>>>>>
>>>>> Aside: test_dir is a lousy name.
>>>>
>>>> Agree but changing names is tricky as people might be using kwargs t=
o set it. Anyway using your description here, keeping the possible rename=
 for a separate patchset (if needed).
>>>
>>> I'm merely observing the lousiness of this name.  I'm not asking you =
to
>>> do anything about it :)
>>>
>>>>>> +        @param monitor_address: custom address for QMP monitor
>>>>>
>>>>> Yes, but what *is* a custom address?  Its user _base_args() appears=
 to
>>>>> expect either a pair of strings (host, port) or a string filename.
>>>>>
>>>>
>>>> If you insist I can add something like "a tuple(host, port) or strin=
g to specify path", but I find it unnecessary detailed...
>>>
>>> I'm not the maintainer, I'm definitely not insisting on anything.
>>>
>>> If you're aiming for brevity, then drop "custom".
>>>
>>
>> OK, removing in v6
>>
>>>>>> +        @param socket_scm_helper: path to scm_helper binary (to f=
orward fds)
>>>>>
>>>>> What is an scm_helper, and why would I want to use it?
>>>>>
>>>>
>>>> To forward a file descriptor. It's for example used in tests/qemu-io=
tests/045 or tests/qemu-iotests/147
>>>
>>> What about "socket_scm_helper: helper program, required for send_fd_s=
cm()"?
>>>
>>>>>> +        @param debug: enable debug mode (forwarded to QMP helper =
and such)
>>>>>
>>>>> What is a QMP helper?  To what else is debug forwarded?
>>>>>
>>>>
>>>> Debug is set in `self._debug` and can be consumed by anyone who has =
access to this variable. Currently that is the QMP, but people can inheri=
t and use that variable to adjust their behavior.
>>>
>>> Drop the parenthesis?
>>>
>>
>> OK
>>
>>>>>> +        @note: Qemu process is not started until launch() is used=
=2E
>>>>>
>>>>> until launch().
>>>>>
>>>>
>>>> OK
>>>
>>> One more thing: what the use of "@param"?
>>>
>>
>> The API documentation can be autogenerated by doxygen, it uses those k=
eywords to make it easier to read (and to create links, warnings, ...)
>=20
> "Can" or "could"?  As far as I can tell, we aren't actually using
> doxygen for anything, are we?  Just like we aren't actually using
> GTK-Doc.  Yet its comment rash^H^H^H^Hannotations can be found here and=

> there, commonly mixed up with unannotated code, and often syntactically=

> invalid.  No surprise, since they've never been processed by their
> intended consumer.
>=20
> If we decide we want to generate documentation, we should pick *one*
> system and stick to it.  Having every deveoper sprinkle "his" code with=

> the annotations he's used to from elsewhere will do us no good.
>=20

I'm not aware of any official documentation (as those scripts are pretty =
much internal), anyway IDEs like them as well. I saw the docstring notati=
on on other places (qmp.py, qtest.py so I went with that in this version.=


PS: I'm used to sphinx notation (:param)

>>>>>> +        '''
>>>>>
>>>>> It's an improvement.
>>>>>
>>>>>>          if name is None:
>>>>>>              name =3D "qemu-%d" % os.getpid()
>>>>>>          if monitor_address is None:
>>>>>> @@ -33,12 +47,13 @@ class QEMUMachine(object):
>>>>>>          self._qemu_log_path =3D os.path.join(test_dir, name + ".l=
og")
>>>>>>          self._popen =3D None
>>>>>>          self._binary =3D binary
>>>>>> -        self._args =3D list(args) # Force copy args in case we mo=
dify them
>>>>>> +        self._args =3D list(args)     # Force copy args in case w=
e modify them
>>>>>>          self._wrapper =3D wrapper
>>>>>>          self._events =3D []
>>>>>>          self._iolog =3D None
>>>>>>          self._socket_scm_helper =3D socket_scm_helper
>>>>>>          self._debug =3D debug
>>>>>> +        self._qmp =3D None
>>>>>> =20
>>>>>>      # This can be used to add an unused monitor instance.
>>>>>>      def add_monitor_telnet(self, ip, port):
>>>>>> @@ -64,16 +79,16 @@ class QEMUMachine(object):
>>>>>>          if self._socket_scm_helper is None:
>>>>>>              print >>sys.stderr, "No path to socket_scm_helper set=
"
>>>>>>              return -1
>>>>>> -        if os.path.exists(self._socket_scm_helper) =3D=3D False:
>>>>>> +        if not os.path.exists(self._socket_scm_helper):
>>>>>>              print >>sys.stderr, "%s does not exist" % self._socke=
t_scm_helper
>>>>>>              return -1
>>>>>>          fd_param =3D ["%s" % self._socket_scm_helper,
>>>>>>                      "%d" % self._qmp.get_sock_fd(),
>>>>>>                      "%s" % fd_file_path]
>>>>>>          devnull =3D open('/dev/null', 'rb')
>>>>>> -        p =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdout=3D=
sys.stdout,
>>>>>> -                             stderr=3Dsys.stderr)
>>>>>> -        return p.wait()
>>>>>> +        proc =3D subprocess.Popen(fd_param, stdin=3Ddevnull, stdo=
ut=3Dsys.stdout,
>>>>>> +                                stderr=3Dsys.stderr)
>>>>>> +        return proc.wait()
>>>>>> =20
>>>>>>      @staticmethod
>>>>>>      def _remove_if_exists(path):
>>>>>> @@ -99,8 +114,8 @@ class QEMUMachine(object):
>>>>>>          return self._popen.pid
>>>>>> =20
>>>>>>      def _load_io_log(self):
>>>>>> -        with open(self._qemu_log_path, "r") as fh:
>>>>>> -            self._iolog =3D fh.read()
>>>>>> +        with open(self._qemu_log_path, "r") as iolog:
>>>>>> +            self._iolog =3D iolog.read()
>>>>>> =20
>>>>>>      def _base_args(self):
>>>>>>          if isinstance(self._monitor_address, tuple):
>>>>>> @@ -114,8 +129,8 @@ class QEMUMachine(object):
>>>>>>                  '-display', 'none', '-vga', 'none']
>>>>>> =20
>>>>>>      def _pre_launch(self):
>>>>>> -        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_a=
ddress, server=3DTrue,
>>>>>> -                                                debug=3Dself._deb=
ug)
>>>>>> +        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_a=
ddress,
>>>>>> +                                                server=3DTrue, de=
bug=3Dself._debug)
>>>>>
>>>>> Recommend to break the line between the last two arguments.
>>>>>
>>>>
>>>> I'm not used to do that, but I can most certainly do that. Do you wa=
nt me to change all places (eg. in the next chunk)
>>>
>>> PEP8 asks you to limit all lines to a maximum of 79 characters.  This=

>>> one is right at the maximum.  Tolerable, but I prefer my lines a bit
>>> shorter.  Use your judgement.
>>>
>>
>> OK, I though you want to enforce the one-arg-per-line limit. I usually=
 go with <=3D79 (+ '\n') so this is fine by me, but I'll put it into next=
 line if that makes you happier.
>=20
> Please wrap your lines in e-mail, too :)
>=20

Oh, sorry, this is a tough one... I'll take a look at the options (thunde=
rbird)

>>>>>> =20
>>>>>>      def _post_launch(self):
>>>>>>          self._qmp.accept()
>>>>>> @@ -131,9 +146,11 @@ class QEMUMachine(object):
>>>>>>          qemulog =3D open(self._qemu_log_path, 'wb')
>>>>>>          try:
>>>>>>              self._pre_launch()
>>>>>> -            args =3D self._wrapper + [self._binary] + self._base_=
args() + self._args
>>>>>> +            args =3D (self._wrapper + [self._binary] + self._base=
_args() +
>>>>>> +                    self._args)
>>>>>>              self._popen =3D subprocess.Popen(args, stdin=3Ddevnul=
l, stdout=3Dqemulog,
>>>>>> -                                           stderr=3Dsubprocess.ST=
DOUT, shell=3DFalse)
>>>>>> +                                           stderr=3Dsubprocess.ST=
DOUT,
>>>>>> +                                           shell=3DFalse)
>>>>>>              self._post_launch()
>>>>>>          except:
>>>>>>              if self.is_running():
>>>>>> @@ -149,28 +166,34 @@ class QEMUMachine(object):
>>>>>>              try:
>>>>>>                  self._qmp.cmd('quit')
>>>>>>                  self._qmp.close()
>>>>>> -            except:
>>>>>> +            except:     # kill VM on any failure pylint: disable=3D=
W0702
>>>>>
>>>>> The bare except is almost certainly inappropriate.  Are you sure we=

>>>>> should silence pylint?
>>>>>
>>>>> Note that there's another bare except in launch(), visible in the
>>>>> previous patch hunk.  I guess pylint is okay with that one because =
it
>>>>> re-throws the exception.
>>>>>
>>>>> In case we should silence pylint: what's the scope of this magic py=
lint
>>>>> comment?  Can we use the symbolic disable=3Dbare-except?
>>>>>
>>>>
>>>> Yep, we can use symbolic name as well. Well more appropriate would b=
e to catch `SystemExit` and `KeyboardInterrupt`, treat them and raise the=
m and then ignore the rest of exceptions. I'll do that in the next versio=
n...
>>>>
>>>>>>                  self._popen.kill()
>>>>>> =20
>>>>>>              exitcode =3D self._popen.wait()
>>>>>>              if exitcode < 0:
>>>>>> -                sys.stderr.write('qemu received signal %i: %s\n' =
% (-exitcode, ' '.join(self._args)))
>>>>>> +                sys.stderr.write('qemu received signal %i: %s\n'
>>>>>> +                                 % (-exitcode, ' '.join(self._arg=
s)))
>>>>>>              self._load_io_log()
>>>>>>              self._post_shutdown()
>>>>>> =20
>>>>>>      underscore_to_dash =3D string.maketrans('_', '-')
>>>>>> +
>>>>>>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>>>>>>          '''Invoke a QMP command and return the result dict'''
>>>>>
>>>>> Make that "and return the response", because that's how
>>>>> docs/interop/qmp-spec.txt calls the thing.
>>>>>
>>>>
>>>> Sure, no problem. I wanted to stress-out it's a dict and not encoded=
 string, but it's probably given by the context.
>>>
>>> "return the response dict" would be fine with me.
>>>
>>
>> Yes, I like that.
>>
>>>>>>          qmp_args =3D dict()
>>>>>> -        for k in args.keys():
>>>>>> +        for key in args.keys():
>>>>>>              if conv_keys:
>>>>>> -                qmp_args[k.translate(self.underscore_to_dash)] =3D=
 args[k]
>>>>>> +                qmp_args[key.translate(self.underscore_to_dash)] =
=3D args[key]
>>>>>>              else:
>>>>>> -                qmp_args[k] =3D args[k]
>>>>>> +                qmp_args[key] =3D args[key]
>>>>>> =20
>>>>>>          return self._qmp.cmd(cmd, args=3Dqmp_args)
>>>>>> =20
>>>>>>      def command(self, cmd, conv_keys=3DTrue, **args):
>>>>>> +        '''
>>>>>> +        Invoke a QMP command and on success return result dict or=
 on failure
>>>>>> +        raise exception with details.
>>>>>> +        '''
>>>>>
>>>>> I'm afraid "result dict" is wrong: it need not be a dict.  "on fail=
ure
>>>>> raise exception" adds precious little information, and "with detail=
s"
>>>>> adds none.
>>>>>
>>>>> Perhaps:
>>>>>
>>>>>            Invoke a QMP command.
>>>>>            On success return the return value.
>>>>>            On failure raise an exception.
>>>>>
>>>>
>>>> That is quite more verbose than I'd like and result in the same (for=
 non-native speaker), but I have no strong opinion here so changing it to=
 your version in v2.
>>>>
>>>>> The last sentence is too vague, but it's hard to do better because.=
=2E.
>>>>>
>>>>>>          reply =3D self.qmp(cmd, conv_keys, **args)
>>>>>>          if reply is None:
>>>>>>              raise Exception("Monitor is closed")
>>>>>
>>>>> ... we raise Exception!  This code is a *turd* (pardon my french), =
and
>>>>> PEP8 / pylint violations are the least of its problems.
>>>>>
>>>>
>>>> Yep, adding rework-exceptions to my TODO list (for a future patchset=
)
>>>>
>>>>>> @@ -193,15 +216,18 @@ class QEMUMachine(object):
>>>>>>          return events
>>>>>> =20
>>>>>>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
>>>>>> -        # Test if 'match' is a recursive subset of 'event'
>>>>>> -        def event_match(event, match=3DNone):
>>>>>> +        '''Wait for event in QMP, optionally filter results by ma=
tch.'''
>>>>>
>>>>> What is match?
>>>>>
>>>>> name and timeout not worth mentioning?
>>>>>
>>>>
>>>> IMO this does not require full-blown documentation, it's not really =
a user-facing API and sometimes shorter is better. Anyway if you insist I=
 can add full documentation of each parameter. I can even add `:type:` an=
d `:returns:` and perhaps some `:warns:` and `:notes:` and I should desce=
nd and note all the possible `:raises:`.
>>>>
>>>> ... the point I'm trying to make is I don't think it's necessary to =
go that much into details. Anyway if you think the params are necessary t=
o list, then I can do that.
>>>
>>> Use your judgement.  The more detailed comments you add, the more
>>> questions you'll get ;)
>>>
>>
>> Sure, I'll try to improve (but not too much) that in the v6.
>>
>>>>>> +        # Test if 'match' is a recursive subset of 'event'; skips=
 branch
>>>>>> +        # processing on match's value `None`
>>>>>
>>>>> What's a "recursive subset"?  What's "branch processing"?
>>>>>
>>>>> There's an unusual set of quotes around `None`.
>>>>>
>>>>
>>>> Basically I was surprised why this function exists as one can direct=
ly compare dicts. It's because it works as the stock dict compare only on=
 value "None" it breaks and assumes that "branch" matches. That's why I l=
isted the example as I'm unsure how to explain it in a human language.
>>>>
>>>> As for the `None`, in sphinx/doxygen it becomes "block" so I'm used =
to these, anyway people use `'`s and `"`s here so I'll change it in next =
version to be consistent.
>>>
>>> According to git-grep, we're using neither sphinx nor doxygen right n=
ow.
>>>
>>
>> yep, as I said I'll change it for `"`.
>=20
> I'd prefer plain None over "None", because the former is clearly the
> built-in constant None, while the latter looks like a string.
>=20

Sure

>>>>>> +        #    {"foo": {"bar": 1} matches {"foo": None}
>>>>>
>>>>> Aha: None servers as wildcard.
>>>>
>>>> Exactly.
>>>>
>>>>>
>>>>>> +        def _event_match(event, match=3DNone):
>>>>>
>>>>> Any particular reason for renaming this function?
>>>>>
>>>>
>>>> To emphasize it's internal, not a strong opinion but IMO looks bette=
r this way.
>>>
>>> It's a nested function, how could it *not* be internal?
>>>
>>
>> It is always internal for the computer, but humans sometimes need more=
 pointers. I can drop this part if you really dislike that change but I'm=
 used to this notation.
>=20
> PEP8:
>=20
>     Method Names and Instance Variables
>=20
>     Use the function naming rules: lowercase with words separated by
>     underscores as necessary to improve readability.
>=20
>     Use one leading underscore only for non-public methods and instance=

>     variables.
>=20
> A nested function is not a method or instance variable.
>=20

OK, I'll keep the name and send v6 probably tomorrow.

Regards,
Luk=C3=A1=C5=A1

>>>>>>              if match is None:
>>>>>>                  return True
>>>>>> =20
>>>>>>              for key in match:
>>>>>>                  if key in event:
>>>>>>                      if isinstance(event[key], dict):
>>>>>> -                        if not event_match(event[key], match[key]=
):
>>>>>> +                        if not _event_match(event[key], match[key=
]):
>>>>>>                              return False
>>>>>>                      elif event[key] !=3D match[key]:
>>>>>>                          return False
>>>>>> @@ -212,18 +238,22 @@ class QEMUMachine(object):
>>>>>> =20
>>>>>>          # Search cached events
>>>>>>          for event in self._events:
>>>>>> -            if (event['event'] =3D=3D name) and event_match(event=
, match):
>>>>>> +            if (event['event'] =3D=3D name) and _event_match(even=
t, match):
>>>>>>                  self._events.remove(event)
>>>>>>                  return event
>>>>>> =20
>>>>>>          # Poll for new events
>>>>>>          while True:
>>>>>>              event =3D self._qmp.pull_event(wait=3Dtimeout)
>>>>>> -            if (event['event'] =3D=3D name) and event_match(event=
, match):
>>>>>> +            if (event['event'] =3D=3D name) and _event_match(even=
t, match):
>>>>>>                  return event
>>>>>>              self._events.append(event)
>>>>>> =20
>>>>>>          return None
>>>>>> =20
>>>>>>      def get_log(self):
>>>>>> +        '''
>>>>>> +        After self.shutdown or failed qemu execution this returns=
 the output
>>>>>
>>>>> Comma after execution, please.
>>>>>
>>>>
>>>> OK
>>>>
>>>>>> +        of the qemu process.
>>>>>> +        '''
>>>>>>          return self._iolog
>>>>>
>>>>> I understand this code was factored out of qemu-iotests for use by
>>>>> qtest.py.  That's okay, but I'd rather not serve as its maintainer.=

>>>>> -E2MUCH...
>>>>>
>>>>
>>>> Yep, anyway it contains several useful methods/helpers and fixing ba=
sic issues is the simplest way to get to know the code (and the submittin=
g process). Thank you for your time.
>>>
>>> You're welcome!
>>>
>>
>> Thanks again,
>> Luk=C3=A1=C5=A1



--raJ2osMbRbl9DubdJHlhmMeP9OHohnvjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZld1hExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGV
vQf7BHHdX+uw7PL2mHOEzzS1wV2fnlkZPivS6HAgZdnYS4EJH2GyeiKdGB7J5Zu/
bTjSbBSD/Kh7kKklHIH5+f4VNN/FphX8v8V5VrpPX8hhGb3TArNs5hPPZEM+7rDC
iJuj+ZyUffDrFzHYPh2SJSbUuix4KQKFVw0UJ+/qVXEK4+vkD7O22ClllMmHkT2y
EY9CvkD3ZNfs1FA7JBeg7JquMFcCuDs2C7O4MiA1Ktm44C2yDyMb1yx4qY1bdZmf
ZJmdjKiXYwcEpn7w1f+YGKTLxcqBqV0X3ujhm1d45B0DzINHovKa4MMUnJBrdWhd
7wCk0lXg1SbP2nLyU887KHrypg==
=UU5M
-----END PGP SIGNATURE-----

--raJ2osMbRbl9DubdJHlhmMeP9OHohnvjj--
