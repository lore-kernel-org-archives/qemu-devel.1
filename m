Received: from eggs.gnu.org ([2001:4830:134:3::10]:50389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnTk-0000n3-2y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnTi-0007Lz-7s
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:48:00 -0400
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-3-mreitz@redhat.com>
	<8760fpwatr.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <665bddbf-39c4-0678-b82d-ad7dfa7f1a9e@redhat.com>
Date: Wed, 21 Jun 2017 23:47:46 +0200
MIME-Version: 1.0
In-Reply-To: <8760fpwatr.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PChrBRwvnIV4d9lXtC5xfNXgVStcmfj9w"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PChrBRwvnIV4d9lXtC5xfNXgVStcmfj9w
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <665bddbf-39c4-0678-b82d-ad7dfa7f1a9e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qapi: Add qobject_is_equal()
References: <20170621134744.8047-1-mreitz@redhat.com>
 <20170621134744.8047-3-mreitz@redhat.com> <8760fpwatr.fsf@dusky.pond.sub.org>
In-Reply-To: <8760fpwatr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-21 18:43, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> This generic function (along with its implementations for different
>> types) determines whether two QObjects are equal.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/qapi/qmp/qbool.h   |  1 +
>>  include/qapi/qmp/qdict.h   |  1 +
>>  include/qapi/qmp/qfloat.h  |  1 +
>>  include/qapi/qmp/qint.h    |  1 +
>>  include/qapi/qmp/qlist.h   |  1 +
>>  include/qapi/qmp/qnull.h   |  2 ++
>>  include/qapi/qmp/qobject.h |  9 +++++++++
>>  include/qapi/qmp/qstring.h |  1 +
>>  qobject/qbool.c            |  8 ++++++++
>>  qobject/qdict.c            | 28 ++++++++++++++++++++++++++++
>>  qobject/qfloat.c           |  8 ++++++++
>>  qobject/qint.c             |  8 ++++++++
>>  qobject/qlist.c            | 30 ++++++++++++++++++++++++++++++
>>  qobject/qnull.c            |  5 +++++
>>  qobject/qobject.c          | 30 ++++++++++++++++++++++++++++++
>>  qobject/qstring.c          |  9 +++++++++
>>  16 files changed, 143 insertions(+)
>=20
> No unit test?

*cough*

>> diff --git a/include/qapi/qmp/qbool.h b/include/qapi/qmp/qbool.h
>> index a41111c..f77ea86 100644
>> --- a/include/qapi/qmp/qbool.h
>> +++ b/include/qapi/qmp/qbool.h
>> @@ -24,6 +24,7 @@ typedef struct QBool {
>>  QBool *qbool_from_bool(bool value);
>>  bool qbool_get_bool(const QBool *qb);
>>  QBool *qobject_to_qbool(const QObject *obj);
>> +bool qbool_is_equal(const QObject *x, const QObject *y);
>>  void qbool_destroy_obj(QObject *obj);
>> =20
>>  #endif /* QBOOL_H */
>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> index 188440a..134a526 100644
>> --- a/include/qapi/qmp/qdict.h
>> +++ b/include/qapi/qmp/qdict.h
>> @@ -41,6 +41,7 @@ void qdict_del(QDict *qdict, const char *key);
>>  int qdict_haskey(const QDict *qdict, const char *key);
>>  QObject *qdict_get(const QDict *qdict, const char *key);
>>  QDict *qobject_to_qdict(const QObject *obj);
>> +bool qdict_is_equal(const QObject *x, const QObject *y);
>>  void qdict_iter(const QDict *qdict,
>>                  void (*iter)(const char *key, QObject *obj, void *opa=
que),
>>                  void *opaque);
>> diff --git a/include/qapi/qmp/qfloat.h b/include/qapi/qmp/qfloat.h
>> index b5d1583..318e91e 100644
>> --- a/include/qapi/qmp/qfloat.h
>> +++ b/include/qapi/qmp/qfloat.h
>> @@ -24,6 +24,7 @@ typedef struct QFloat {
>>  QFloat *qfloat_from_double(double value);
>>  double qfloat_get_double(const QFloat *qi);
>>  QFloat *qobject_to_qfloat(const QObject *obj);
>> +bool qfloat_is_equal(const QObject *x, const QObject *y);
>>  void qfloat_destroy_obj(QObject *obj);
>> =20
>>  #endif /* QFLOAT_H */
>> diff --git a/include/qapi/qmp/qint.h b/include/qapi/qmp/qint.h
>> index 3aaff76..20975da 100644
>> --- a/include/qapi/qmp/qint.h
>> +++ b/include/qapi/qmp/qint.h
>> @@ -23,6 +23,7 @@ typedef struct QInt {
>>  QInt *qint_from_int(int64_t value);
>>  int64_t qint_get_int(const QInt *qi);
>>  QInt *qobject_to_qint(const QObject *obj);
>> +bool qint_is_equal(const QObject *x, const QObject *y);
>>  void qint_destroy_obj(QObject *obj);
>> =20
>>  #endif /* QINT_H */
>> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
>> index 5dc4ed9..4380a5b 100644
>> --- a/include/qapi/qmp/qlist.h
>> +++ b/include/qapi/qmp/qlist.h
>> @@ -57,6 +57,7 @@ QObject *qlist_peek(QList *qlist);
>>  int qlist_empty(const QList *qlist);
>>  size_t qlist_size(const QList *qlist);
>>  QList *qobject_to_qlist(const QObject *obj);
>> +bool qlist_is_equal(const QObject *x, const QObject *y);
>>  void qlist_destroy_obj(QObject *obj);
>> =20
>>  static inline const QListEntry *qlist_first(const QList *qlist)
>> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
>> index 69555ac..9299683 100644
>> --- a/include/qapi/qmp/qnull.h
>> +++ b/include/qapi/qmp/qnull.h
>> @@ -23,4 +23,6 @@ static inline QObject *qnull(void)
>>      return &qnull_;
>>  }
>> =20
>> +bool qnull_is_equal(const QObject *x, const QObject *y);
>> +
>>  #endif /* QNULL_H */
>> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
>> index ef1d1a9..cac72e3 100644
>> --- a/include/qapi/qmp/qobject.h
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -68,6 +68,15 @@ static inline void qobject_incref(QObject *obj)
>>  }
>> =20
>>  /**
>> + * qobject_is_equal(): Returns whether the two objects are equal.
>=20
> Imperative mood, please: Return whether...

OK, will do here and everywhere else.

>> + *
>> + * Any of the pointers may be NULL; will return true if both are. Wil=
l always
>> + * return false if only one is (therefore a QNull object is not consi=
dered equal
>> + * to a NULL pointer).
>> + */
>=20
> Humor me: wrap comment lines around column 70, and put two spaces
> between sentences.

Do I hear "one checkpatch.pl per subsystem"?

Yes, I know, there's no point to. Why should anyone not break comments
after 70 lines and not use two spaces after full stops? O:-)

> Same for the other function comments.

Sure, will do.

>> +bool qobject_is_equal(const QObject *x, const QObject *y);
>> +
>> +/**
>>   * qobject_destroy(): Free resources used by the object
>>   */
>>  void qobject_destroy(QObject *obj);
>> diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
>> index 10076b7..65c05a9 100644
>> --- a/include/qapi/qmp/qstring.h
>> +++ b/include/qapi/qmp/qstring.h
>> @@ -31,6 +31,7 @@ void qstring_append_int(QString *qstring, int64_t va=
lue);
>>  void qstring_append(QString *qstring, const char *str);
>>  void qstring_append_chr(QString *qstring, int c);
>>  QString *qobject_to_qstring(const QObject *obj);
>> +bool qstring_is_equal(const QObject *x, const QObject *y);
>>  void qstring_destroy_obj(QObject *obj);
>> =20
>>  #endif /* QSTRING_H */
>> diff --git a/qobject/qbool.c b/qobject/qbool.c
>> index 0606bbd..f1d1719 100644
>> --- a/qobject/qbool.c
>> +++ b/qobject/qbool.c
>> @@ -52,6 +52,14 @@ QBool *qobject_to_qbool(const QObject *obj)
>>  }
>> =20
>>  /**
>> + * qbool_is_equal(): Tests whether the two QBools are equal
>=20
> Return whether ...
>=20
>> + */
>> +bool qbool_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    return qobject_to_qbool(x)->value =3D=3D qobject_to_qbool(y)->val=
ue;
>> +}
>> +
>> +/**
>>   * qbool_destroy_obj(): Free all memory allocated by a
>>   * QBool object
>>   */
>> diff --git a/qobject/qdict.c b/qobject/qdict.c
>> index 88e2ecd..ca919bc 100644
>> --- a/qobject/qdict.c
>> +++ b/qobject/qdict.c
>> @@ -410,6 +410,34 @@ void qdict_del(QDict *qdict, const char *key)
>>  }
>> =20
>>  /**
>> + * qdict_is_equal(): Tests whether the two QDicts are equal
>> + *
>> + * Here, equality means whether they contain the same keys and whethe=
r the
>> + * respective values are in turn equal (i.e. invoking qobject_is_equa=
l() on them
>> + * yields true).
>> + */
>> +bool qdict_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    const QDict *dict_x =3D qobject_to_qdict(x), *dict_y =3D qobject_=
to_qdict(y);
>=20
> I'm fine with multiple initializers in one declaration, but I think thi=
s
> one would look tidier as
>=20
>        const QDict *dict_x =3D qobject_to_qdict(x);
>        const QDict *dict_y =3D qobject_to_qdict(y);

I don't mind.

>> +    const QDictEntry *e;
>> +
>> +    if (qdict_size(dict_x) !=3D qdict_size(dict_y)) {
>> +        return false;
>> +    }
>> +
>> +    for (e =3D qdict_first(dict_x); e; e =3D qdict_next(dict_x, e)) {=

>> +        const QObject *obj_x =3D qdict_entry_value(e);
>> +        const QObject *obj_y =3D qdict_get(dict_y, qdict_entry_key(e)=
);
>> +
>> +        if (!qobject_is_equal(obj_x, obj_y)) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +/**
>>   * qdict_destroy_obj(): Free all the memory allocated by a QDict
>>   */
>>  void qdict_destroy_obj(QObject *obj)
>> diff --git a/qobject/qfloat.c b/qobject/qfloat.c
>> index d5da847..291ecc4 100644
>> --- a/qobject/qfloat.c
>> +++ b/qobject/qfloat.c
>> @@ -52,6 +52,14 @@ QFloat *qobject_to_qfloat(const QObject *obj)
>>  }
>> =20
>>  /**
>> + * qfloat_is_equal(): Tests whether the two QFloats are equal
>> + */
>> +bool qfloat_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    return qobject_to_qfloat(x)->value =3D=3D qobject_to_qfloat(y)->v=
alue;
>> +}
>> +
>> +/**
>>   * qfloat_destroy_obj(): Free all memory allocated by a
>>   * QFloat object
>>   */
>> diff --git a/qobject/qint.c b/qobject/qint.c
>> index d7d1b30..f638cb7 100644
>> --- a/qobject/qint.c
>> +++ b/qobject/qint.c
>> @@ -51,6 +51,14 @@ QInt *qobject_to_qint(const QObject *obj)
>>  }
>> =20
>>  /**
>> + * qint_is_equal(): Tests whether the two QInts are equal
>> + */
>> +bool qint_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    return qobject_to_qint(x)->value =3D=3D qobject_to_qint(y)->value=
;
>> +}
>> +
>> +/**
>>   * qint_destroy_obj(): Free all memory allocated by a
>>   * QInt object
>>   */
>> diff --git a/qobject/qlist.c b/qobject/qlist.c
>> index 86b60cb..652fc53 100644
>> --- a/qobject/qlist.c
>> +++ b/qobject/qlist.c
>> @@ -140,6 +140,36 @@ QList *qobject_to_qlist(const QObject *obj)
>>  }
>> =20
>>  /**
>> + * qlist_is_equal(): Tests whether the two QLists are equal
>> + *
>> + * In order to be considered equal, the respective two objects at eac=
h index of
>> + * the two lists have to compare equal (regarding qobject_is_equal())=
, and both
>> + * lists have to have the same number of elements.
>> + * That means, both lists have to contain equal objects in equal orde=
r.
>> + */
>> +bool qlist_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    const QList *list_x =3D qobject_to_qlist(x), *list_y =3D qobject_=
to_qlist(y);
>> +    const QListEntry *entry_x, *entry_y;
>> +
>> +    entry_x =3D qlist_first(list_x);
>> +    entry_y =3D qlist_first(list_y);
>> +
>> +    while (entry_x && entry_y) {
>> +        if (!qobject_is_equal(qlist_entry_obj(entry_x),
>> +                              qlist_entry_obj(entry_y)))
>> +        {
>> +            return false;
>> +        }
>> +
>> +        entry_x =3D qlist_next(entry_x);
>> +        entry_y =3D qlist_next(entry_y);
>> +    }
>> +
>> +    return !entry_x && !entry_y;
>> +}
>> +
>> +/**
>>   * qlist_destroy_obj(): Free all the memory allocated by a QList
>>   */
>>  void qlist_destroy_obj(QObject *obj)
>> diff --git a/qobject/qnull.c b/qobject/qnull.c
>> index b3cc85e..af5453d 100644
>> --- a/qobject/qnull.c
>> +++ b/qobject/qnull.c
>> @@ -19,3 +19,8 @@ QObject qnull_ =3D {
>>      .type =3D QTYPE_QNULL,
>>      .refcnt =3D 1,
>>  };
>> +
>> +bool qnull_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    return true;
>> +}
>> diff --git a/qobject/qobject.c b/qobject/qobject.c
>> index fe4fa10..af2869a 100644
>> --- a/qobject/qobject.c
>> +++ b/qobject/qobject.c
>> @@ -28,3 +28,33 @@ void qobject_destroy(QObject *obj)
>>      assert(QTYPE_QNULL < obj->type && obj->type < QTYPE__MAX);
>>      qdestroy[obj->type](obj);
>>  }
>> +
>> +
>> +static bool (*qis_equal[QTYPE__MAX])(const QObject *, const QObject *=
) =3D {
>> +    [QTYPE_NONE] =3D NULL,               /* No such object exists */
>> +    [QTYPE_QNULL] =3D qnull_is_equal,
>> +    [QTYPE_QINT] =3D qint_is_equal,
>> +    [QTYPE_QSTRING] =3D qstring_is_equal,
>> +    [QTYPE_QDICT] =3D qdict_is_equal,
>> +    [QTYPE_QLIST] =3D qlist_is_equal,
>> +    [QTYPE_QFLOAT] =3D qfloat_is_equal,
>> +    [QTYPE_QBOOL] =3D qbool_is_equal,
>> +};
>> +
>> +bool qobject_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    /* We cannot test x =3D=3D y because an object does not need to b=
e equal to
>> +     * itself (e.g. NaN floats are not). */
>> +
>> +    if (!x && !y) {
>> +        return true;
>> +    }
>> +
>> +    if (!x || !y || x->type !=3D y->type) {
>> +        return false;
>> +    }
>> +
>> +    assert(QTYPE_NONE < x->type && x->type < QTYPE__MAX);
>> +
>> +    return qis_equal[x->type](x, y);
>> +}
>> diff --git a/qobject/qstring.c b/qobject/qstring.c
>> index 5da7b5f..a2b51fa 100644
>> --- a/qobject/qstring.c
>> +++ b/qobject/qstring.c
>> @@ -129,6 +129,15 @@ const char *qstring_get_str(const QString *qstrin=
g)
>>  }
>> =20
>>  /**
>> + * qstring_is_equal(): Tests whether the two QStrings are equal
>> + */
>> +bool qstring_is_equal(const QObject *x, const QObject *y)
>> +{
>> +    return !strcmp(qobject_to_qstring(x)->string,
>> +                   qobject_to_qstring(y)->string);
>> +}
>> +
>> +/**
>>   * qstring_destroy_obj(): Free all memory allocated by a QString
>>   * object
>>   */
>=20
> Address my nitpicks, and either provide a unit test or convince me it's=

> not worth the trouble, and you may add

Unfortunately (for me), it's always worth the trouble.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks again!

Max


--PChrBRwvnIV4d9lXtC5xfNXgVStcmfj9w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSumCEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGFk
CACOHPJLJLjdJh/DX0VASU7DDEnyn/2ZLFdqE1mTK8ObfpFYhGEPhtDLylF8yVSh
PKsSN05xT9tgzxa5Mo/lXmXPnQf1K3m55ksWPZVReTFRiyofoNQMeH2KliX5ylKv
+oIx98EG2r/kYyyN8rKGOJ6LZ/d8SCDRKxYSQwRM5/BDbOWMex5VGiuKs7F3V5Xl
TAt1GDlzpg7+NYNo5HjuakrocsRsKBm3oJAnrJqA1dFXSeZjmcqxdXslQ1Ep8j5G
jWHYyLAb6QWp8ZbUA1Iu0EvGYtuiC/G+XzMORk/TKr+F35IeiDdZdzo9jwXgjtKc
FlXXEcbn7Ark7NlQUMV/JEw+
=EmeX
-----END PGP SIGNATURE-----

--PChrBRwvnIV4d9lXtC5xfNXgVStcmfj9w--
